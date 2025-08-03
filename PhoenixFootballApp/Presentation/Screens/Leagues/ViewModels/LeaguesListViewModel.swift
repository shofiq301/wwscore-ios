//
//  LeaguesListViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 4/21/25.
//
import SwiftUI
import APIFootball
import XSwiftUI
import EasyXConnect
import EasyX
import SwifterSwift
import SDWebImageSwiftUI
import SDWebImage

final class LeaguesListViewModelBindings:IBindings{
    func getDependency() -> LeaguesListViewModel {
        
        if let viewmodel = try? DIContainer.shared.resolve(LeaguesListViewModel.self){
            return viewmodel
        }
        
        
        let repository = LeaguesRepositoryBindings().getDependency()
        
        let viewMoedel = LeaguesListViewModel(repository: repository)
        
        DIContainer.shared.register(LeaguesListViewModel.self, factory: { _ in viewMoedel})
        
        return viewMoedel
        
    }
}


final class LeaguesListViewModel: ObservableObject {
    // MARK: - Properties
    private let repository: ILeaguesRepository
    
    @Published private(set) var leagues: [LeagueData] = []
    @Published private(set) var flagMap: [String: String] = [:]
    
    // Use a Set for faster lookups of top league IDs
    private let topLeagueIDs: Set<Int> = [
        1,   // FIFA World Cup
        2,   // UEFA Champions League
        3,   // UEFA Europa League
        5,   // UEFA Nations League
        6,   // Africa Cup of Nations
        9,   // Copa America
        39,  // Premier League (England)
        140, // La Liga (Spain)
        78   // Bundesliga (Germany)
    ]
    
    // MARK: - Lifecycle
    init(repository: ILeaguesRepository) {
        self.repository = repository
        loadFlagMap()
    }
    
    // MARK: - Public Methods
    @MainActor
    func getAllLeagues() async {
        do {
            // 1) Fetch leagues on the main actor
            leagues = try await repository.getLeagues()
            
            // 2) Start updating flags (this already offloads internal work)
            await updateFlagsIfNeeded()
            
            // 3) Snap a local copy of leagues
            let leaguesCopy = leagues
            
            // 4) Spin off a background task to build your sections
            let sectionsTask = Task.detached(priority: .background) { () -> [(String, [LeagueDetailsData])] in
                // You can either call through to your existing helper:
                return self.buildSections(from: leaguesCopy)
                
                // — or inline the logic directly here if you prefer.
            }
            
            // 5) Await the result of the background task
            let computedSections = await sectionsTask.value
            
            // 6) Assign back on the main actor
            allCompetitions = computedSections
            
            loadMoreCompetitions()
//            let limit = min(10, computedSections.count)
//            allCompetitions = Array(computedSections.prefix(limit))
            let urls = leagues
                .compactMap { URL(string: $0.league.logo) }
            prefetchLogos(in: urls)
            
        } catch {
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }

    /// Extracted helper that *doesn’t* touch any @Published state
    /// so it’s safe to call from a detached task.
    private func buildSections(from leagues: [LeagueData]) -> [(String, [LeagueDetailsData])] {
        var sections: [(String, [LeagueDetailsData])] = []
        
        // 1) International – National teams
        let intl = leagues
            .filter { $0.country.name == "World" }
            .map(\.league)
            .sorted { $0.name < $1.name }
        if !intl.isEmpty {
            sections.append(("International – National teams", intl))
        }
        
        // 2) Group the rest by country
        let grouped = Dictionary(grouping: leagues.filter { $0.country.name != "World" },
                                 by: { $0.country.name })
        
        // 3) Priority countries in order
        let priority = ["England", "Spain", "Germany", "Italy", "France", "Netherlands", "Portugal"] 
        for country in priority {
            if let list = grouped[country] {
                sections.append((country, list.map(\.league).sorted { $0.name < $1.name }))
            }
        }
        
        // 4) All others, alphabetically
        let others = grouped.keys
            .filter { !priority.contains($0) }
            .sorted()
        for country in others {
            if let list = grouped[country] {
                sections.append((country, list.map(\.league).sorted { $0.name < $1.name }))
            }
        }
        
        return sections
    }

    
    func getTopLeagues() -> [LeagueDetailsData] {
        // Use the Set for O(1) lookup efficiency instead of array contains O(n)
        return leagues
            .filter { topLeagueIDs.contains(Int($0.league.id)) }
            .map(\.league)
    }
    
    func getTopLeaguesFromServer(topLeagueIDs:[Int]) -> [LeagueData] {
        // Use the Set for O(1) lookup efficiency instead of array contains O(n)
        return leagues
            .filter { topLeagueIDs.contains(Int($0.league.id)) }
            //.map(\.league)
    }
    
    @Published private(set) var allCompetitions: [(String, [LeagueDetailsData])] = []
       @Published private(set) var visibleCompetitions: [(String, [LeagueDetailsData])] = []

       private let pageSize = 20
       private var currentIndex = 0
    
    /// Load the first `pageSize` sections
      private func loadInitialCompetitions() {
          let limit = min(pageSize, allCompetitions.count)
          visibleCompetitions = Array(allCompetitions.prefix(limit))
          currentIndex = visibleCompetitions.count
      }

      /// Append the next `pageSize` sections (if any)
      func loadMoreCompetitions() {
          guard currentIndex < allCompetitions.count else { return }
          let nextIndex = min(currentIndex + pageSize, allCompetitions.count)
          let slice = allCompetitions[currentIndex..<nextIndex]
          visibleCompetitions.append(contentsOf: slice)
          currentIndex = nextIndex
      }
    
    private func prefetchLogos(in urls: [URL]) {
           // 1) Extract the URLs
           //let urls = leagues
            //   .compactMap { URL(string: $0.league.logo) }
           
           // 2) Dispatch to a background queue (or use Task.detached)
           DispatchQueue.global(qos: .background).async {
               SDWebImagePrefetcher.shared.prefetchURLs(urls,
                   progress: { completed, total in
                       // optional: update a progress indicator
                       // print("Prefetched \(completed) of \(total)")
                   },
                   completed: { finishedCount, skippedCount in
                       print("✅ Prefetched \(finishedCount) images, skipped \(skippedCount)")
                   }
               )
           }
       }

    
    // MARK: - Private Methods
    private func appendCountrySection(_ country: String,
                                     _ groupedLeagues: [String: [LeagueData]],
                                     to sections: inout [(String, [LeagueDetailsData])]) {
        if let data = groupedLeagues[country] {
            let sortedLeagues = data.map(\.league).sorted { $0.name < $1.name }
            sections.append((country, sortedLeagues))
        }
    }
    
    private func loadFlagMap() {
        // Initialize with the predefined flag mappings
        flagMap = CountryFlagMap.initialFlagMap
        let urls = CountryFlagMap.initialFlagMap.keys
            .compactMap { URL(string: $0) }
        prefetchLogos(in: urls)
    }
    
    @MainActor
    private func updateFlagsIfNeeded() async {
        // Detach to avoid blocking the main thread
        let newFlags = await Task.detached(priority: .background) { () -> [String: String] in
            // Create local copies to avoid data races
            let leaguesCopy = self.leagues
            let currentFlagMap = self.flagMap
            
            var flagsToAdd: [String: String] = [:]
            
            // Process leagues in background
            for league in leaguesCopy {
                let countryName = league.country.name
                // Check if flag is missing and available
                if currentFlagMap[countryName] == nil, let countryFlag = league.country.flag {
                    flagsToAdd[countryName] = countryFlag
                }
            }
            
            return flagsToAdd
        }.value
        
        // Update the flagMap with new flags on the main actor
        if !newFlags.isEmpty {
            for (key, value) in newFlags {
                flagMap[key] = value
            }
        }
    }
    
func searchLeagues(key: String) {
    if key.isEmpty {
        loadInitialCompetitions()
    } else {
        visibleCompetitions = allCompetitions.compactMap { section, leagues in
            let filtered = leagues.filter { $0.name.localizedCaseInsensitiveContains(key) }
            return filtered.isEmpty ? nil : (section, filtered)
        }
    }
}
    
    
    func getLeagueByID(id: Int)-> LeagueData?{
        return leagues.first(where: {$0.league.id == id})
    }
}
//
//// MARK: - Flag Map Extension
//private extension LeaguesListViewModel {
//    // Move the large initial flag map to a private extension
//    var initialFlagMap: [String: String] {
//        [
//            "Saudi-Arabia":"https://flagcdn.com/w320/sa.png",
//            "San-Marino":"https://flagcdn.com/w320/sm.png",
//            "Northern-Ireland":"https://flagcdn.com/w320/gb.png",
//            "New-Zealand":"https://flagcdn.com/w320/nz.png",
//            "United-Arab-Emirates":"https://flagcdn.com/w320/ae.png",
//            
//            "South-Africa":"https://flagcdn.com/w320/za.png",
//            "South-Korea":"https://flagcdn.com/w320/kr.png",
//            "Costa-Rica":"https://flagcdn.com/w320/cr.png",
////            "Congo-DR":"https://media.api-sports.io/flags/cg.svg",
////            "Chinese-Taipei":"https://media.api-sports.io/flags/tw.svg",
//            "Burkina-Faso":"https://flagcdn.com/w320/bf.png",
//            
//            "Albania": "https://flagcdn.com/w320/al.png",
//            "Gabon": "https://flagcdn.com/w320/ga.png",
//            "Guadeloupe": "https://flagcdn.com/w320/gp.png",
//            "Grenada": "https://flagcdn.com/w320/gd.png",
//            "Japan": "https://flagcdn.com/w320/jp.png",
//            "Colombia": "https://flagcdn.com/w320/co.png",
//            "USA": "https://flagcdn.com/w320/us.png",
//            "Malaysia": "https://flagcdn.com/w320/my.png",
//            "Turkey": "https://flagcdn.com/w320/tr.png",
//            "Cameroon": "https://flagcdn.com/w320/cm.png",
//            "Palestine": "https://flagcdn.com/w320/ps.png",
//            "France": "https://flagcdn.com/w320/fr.png",
//            "Nicaragua": "https://flagcdn.com/w320/ni.png",
//            "Trinidad-And-Tobago": "https://flagcdn.com/w320/tt.png",
//            "Italy": "https://flagcdn.com/w320/it.png",
//            "Israel": "https://flagcdn.com/w320/il.png",
//            "Iran": "https://flagcdn.com/w320/ir.png",
//            "Thailand": "https://flagcdn.com/w320/th.png",
//            "Syria": "https://flagcdn.com/w320/sy.png",
//            "Ethiopia": "https://flagcdn.com/w320/et.png",
//            "Oman": "https://flagcdn.com/w320/om.png",
//            "Chinese‑Taipei": "https://flagcdn.com/w320/tw.png",
//            "Kenya": "https://flagcdn.com/w320/ke.png",
//            "Faroe‑Islands": "https://flagcdn.com/w320/fo.png",
//            "Mongolia": "https://flagcdn.com/w320/mn.png",
//            "Nigeria": "https://flagcdn.com/w320/ng.png",
//            "Venezuela": "https://flagcdn.com/w320/ve.png",
//            "Pakistan": "https://flagcdn.com/w320/pk.png",
//            "Dominican‑Republic": "https://flagcdn.com/w320/do.png",
//            "Australia": "https://flagcdn.com/w320/au.png",
//            "Peru": "https://flagcdn.com/w320/pe.png",
//            "Hong‑Kong": "https://flagcdn.com/w320/hk.png",
//            "Congo": "https://flagcdn.com/w320/cd.png",
//            "Ecuador": "https://flagcdn.com/w320/ec.png",
//            "Sweden": "https://flagcdn.com/w320/se.png",
//            "Belize": "https://flagcdn.com/w320/bz.png",
//            "Jordan": "https://flagcdn.com/w320/jo.png",
//            "Antigua‑And‑Barbuda": "https://flagcdn.com/w320/ag.png",
//            "Bosnia": "https://flagcdn.com/w320/ba.png",
//            "Bolivia": "https://flagcdn.com/w320/bo.png",
//            "Slovakia": "https://flagcdn.com/w320/sk.png",
//            "Senegal": "https://flagcdn.com/w320/sn.png",
//            "Tajikistan": "https://flagcdn.com/w320/tj.png",
//            "Belarus": "https://flagcdn.com/w320/by.png",
//            "Canada": "https://flagcdn.com/w320/ca.png",
//            "Iceland": "https://flagcdn.com/w320/is.png",
//            "India": "https://flagcdn.com/w320/in.png",
//            "Croatia": "https://flagcdn.com/w320/hr.png",
//            "New‑Zealand": "https://flagcdn.com/w320/nz.png",
//            "Wales": "https://flagcdn.com/w320/gb-wls.png",
//            "Finland": "https://flagcdn.com/w320/fi.png",
//            "Spain": "https://flagcdn.com/w320/es.png",
//            "Vietnam": "https://flagcdn.com/w320/vn.png",
//            "Switzerland": "https://flagcdn.com/w320/ch.png",
//            "Malta": "https://flagcdn.com/w320/mt.png",
//            "China": "https://flagcdn.com/w320/cn.png",
//            "South‑Africa": "https://flagcdn.com/w320/za.png",
//            "Georgia": "https://flagcdn.com/w320/ge.png",
//            "Mauritius": "https://flagcdn.com/w320/mu.png",
//            "Germany": "https://flagcdn.com/w320/de.png",
//            "Guinea": "https://flagcdn.com/w320/gn.png",
//            "Norway": "https://flagcdn.com/w320/no.png",
//            "Kuwait": "https://flagcdn.com/w320/kw.png",
//            "Czech‑Republic": "https://flagcdn.com/w320/cz.png",
//            "Armenia": "https://flagcdn.com/w320/am.png",
//            "Myanmar": "https://flagcdn.com/w320/mm.png",
//            "Fiji": "https://flagcdn.com/w320/fj.png",
//            "San‑Marino": "https://flagcdn.com/w320/sm.png",
//            "Bhutan": "https://flagcdn.com/w320/bt.png",
//            "Philippines": "https://flagcdn.com/w320/ph.png",
//            "Rwanda": "https://flagcdn.com/w320/rw.png",
//            "Ivory‑Coast": "https://flagcdn.com/w320/ci.png",
//            "Andorra": "https://flagcdn.com/w320/ad.png",
//            "Lithuania": "https://flagcdn.com/w320/lt.png",
//            "Argentina": "https://flagcdn.com/w320/ar.png",
//            "Panama": "https://flagcdn.com/w320/pa.png",
//            "Barbados": "https://flagcdn.com/w320/bb.png",
//            "Northern‑Ireland": "https://flagcdn.com/w320/gb-nir.png",
//            "Morocco": "https://flagcdn.com/w320/ma.png",
//            "Lesotho": "https://flagcdn.com/w320/ls.png",
//            "Malawi": "https://flagcdn.com/w320/mw.png",
//            "Montenegro": "https://flagcdn.com/w320/me.png",
//            "England": "https://flagcdn.com/w320/gb-eng.png",
//            "Botswana": "https://flagcdn.com/w320/bw.png",
//            "Nepal": "https://flagcdn.com/w320/np.png",
//            "Algeria": "https://flagcdn.com/w320/dz.png",
//            "Burkina‑Faso": "https://flagcdn.com/w320/bf.png",
//            "Zimbabwe": "https://flagcdn.com/w320/zw.png",
//            "Indonesia": "https://flagcdn.com/w320/id.png",
//            "Honduras": "https://flagcdn.com/w320/hn.png",
//            "Togo": "https://flagcdn.com/w320/tg.png",
//            "Latvia": "https://flagcdn.com/w320/lv.png",
//            "Hungary": "https://flagcdn.com/w320/hu.png",
//            "Scotland": "https://flagcdn.com/w320/gb-sct.png",
//            "El‑Salvador": "https://flagcdn.com/w320/sv.png",
//            "Bangladesh": "https://flagcdn.com/w320/bd.png",
//            "Guatemala": "https://flagcdn.com/w320/gt.png",
//            "Estonia": "https://flagcdn.com/w320/ee.png",
//            "Macedonia": "https://flagcdn.com/w320/mk.png",
//            "Gambia": "https://flagcdn.com/w320/gm.png",
//            "Iraq": "https://flagcdn.com/w320/iq.png",
//            "Mali": "https://flagcdn.com/w320/ml.png",
//            "Poland": "https://flagcdn.com/w320/pl.png",
//            "Ukraine": "https://flagcdn.com/w320/ua.png",
//            "Curacao": "https://flagcdn.com/w320/cw.png",
//            "Jamaica": "https://flagcdn.com/w320/jm.png",
//            "Romania": "https://flagcdn.com/w320/ro.png",
//            "Azerbaijan": "https://flagcdn.com/w320/az.png",
//            "Uganda": "https://flagcdn.com/w320/ug.png",
//            "Kosovo": "https://flagcdn.com/w320/xk.png",
//            "Tunisia": "https://flagcdn.com/w320/tn.png",
//            "Ghana": "https://flagcdn.com/w320/gh.png",
//            "Congo‑DR": "https://flagcdn.com/w320/cg.png",
//            "Serbia": "https://flagcdn.com/w320/rs.png",
//            "Kyrgyzstan": "https://flagcdn.com/w320/kg.png",
//            "Cyprus": "https://flagcdn.com/w320/cy.png",
//            "Turkmenistan": "https://flagcdn.com/w320/tm.png",
//            "Singapore": "https://flagcdn.com/w320/sg.png",
//            "Ireland": "https://flagcdn.com/w320/ie.png",
//            "Bermuda": "https://flagcdn.com/w320/bm.png",
//            "Saudi‑Arabia": "https://flagcdn.com/w320/sa.png",
//            "South‑Korea": "https://flagcdn.com/w320/kr.png",
//            "Egypt": "https://flagcdn.com/w320/eg.png",
//            "Bahrain": "https://flagcdn.com/w320/bh.png",
//            "Angola": "https://flagcdn.com/w320/ao.png",
//            "Greece": "https://flagcdn.com/w320/gr.png",
//            "Costa‑Rica": "https://flagcdn.com/w320/cr.png",
//            "Netherlands": "https://flagcdn.com/w320/nl.png",
//            "Portugal": "https://flagcdn.com/w320/pt.png",
//            "Eswatini": "https://flagcdn.com/w320/sz.png",
//            "Laos": "https://flagcdn.com/w320/la.png",
//            "Luxembourg": "https://flagcdn.com/w320/lu.png",
//            "Macao": "https://flagcdn.com/w320/mo.png",
//            "Yemen": "https://flagcdn.com/w320/ye.png",
//            "Haiti": "https://flagcdn.com/w320/ht.png",
//            "Uzbekistan": "https://flagcdn.com/w320/uz.png",
//            "Liberia": "https://flagcdn.com/w320/lr.png",
//            "Somalia": "https://flagcdn.com/w320/so.png",
//            "Bulgaria": "https://flagcdn.com/w320/bg.png",
//            "Zambia": "https://flagcdn.com/w320/zm.png",
//            "Maldives": "https://flagcdn.com/w320/mv.png",
//            "United‑Arab‑Emirates": "https://flagcdn.com/w320/ae.png",
//            "Brazil": "https://flagcdn.com/w320/br.png",
//            "Aruba": "https://flagcdn.com/w320/aw.png",
//            "Mexico": "https://flagcdn.com/w320/mx.png",
//            "Austria": "https://flagcdn.com/w320/at.png",
//            "Kazakhstan": "https://flagcdn.com/w320/kz.png",
//            "Lebanon": "https://flagcdn.com/w320/lb.png",
//            "Cambodia": "https://flagcdn.com/w320/kh.png",
//            "Qatar": "https://flagcdn.com/w320/qa.png",
//            "Denmark": "https://flagcdn.com/w320/dk.png",
//            "Libya": "https://flagcdn.com/w320/ly.png",
//            "Liechtenstein": "https://flagcdn.com/w320/li.png",
//            "Paraguay": "https://flagcdn.com/w320/py.png",
//            "Belgium": "https://flagcdn.com/w320/be.png",
//            "Russia": "https://flagcdn.com/w320/ru.png",
//            "Namibia": "https://flagcdn.com/w320/na.png",
//            "Burundi": "https://flagcdn.com/w320/bi.png",
//            "Crimea": "https://flagcdn.com/w320/ua.png", // disputed territory
//            "Uruguay": "https://flagcdn.com/w320/uy.png",
//            "Mauritania": "https://flagcdn.com/w320/mr.png",
//            "Benin": "https://flagcdn.com/w320/bj.png",
//            "Gibraltar": "https://flagcdn.com/w320/gi.png",
//            "Tanzania": "https://flagcdn.com/w320/tz.png",
//            "Cuba": "https://flagcdn.com/w320/cu.png",
//            "Moldova": "https://flagcdn.com/w320/md.png",
//            "Sudan": "https://flagcdn.com/w320/sd.png",
//            "Suriname": "https://flagcdn.com/w320/sr.png",
//            "Slovenia": "https://flagcdn.com/w320/si.png",
//            "Chile": "https://flagcdn.com/w320/cl.png"
//        ]
//    }
//}
