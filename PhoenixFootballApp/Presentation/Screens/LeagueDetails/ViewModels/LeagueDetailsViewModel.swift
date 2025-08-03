//
//  LeagueDetailsViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/2/25.
//


import Foundation
import APIFootball
import EasyX


final class LeagueDetailsViewModelBindings:IBindings{
    
    
    
    let leagueID:Int
    
    init(leagueID: Int) {
        self.leagueID = leagueID
    }
    
    func getDependency()->LeagueDetailsViewModel{
        do{
            
//            let viewModel = try? DIContainer.shared.resolve(LeagueDetailsViewModel.self, name: "\(leagueID)")
            let viewModel = try? SmartDI.DI.resolve(LeagueDetailsViewModel.self, name: "\(leagueID)", scope: nil)
            
            
            if let viewModel = viewModel{
                return viewModel
            }else{
                
                let stRepository = StandingsRepositoryBindings().getDependency()
                let repository = LeaguesRepositoryBindings().getDependency()
                let fitureRepo =  FixtureRepositoryBindings().getDependency()
                let topPermersRepository = TopPerformersRepositoryBindings().getDependency()
                let viewModel = LeagueDetailsViewModel(leagueID: leagueID, repository: repository, fixtureRepository: fitureRepo,standingRepository: stRepository,topPerformersRepository: topPermersRepository)
                
                SmartDI.DI.register(LeagueDetailsViewModel.self, name: "\(leagueID)") { r in
                    viewModel
                }
                
                return viewModel
            }
        }
    }
}


final class LeagueDetailsViewModel:ObservableObject{
    
   private let leagueID:Int
    
    private let repository: ILeaguesRepository
    private let fixtureRepository: IFixtureRepository
    private let standingRepository: IStandingRepository
    private let topPerformersRepository: ITopPerformersRepository
    
    
    init(leagueID: Int, repository: ILeaguesRepository, fixtureRepository: IFixtureRepository,standingRepository: IStandingRepository,topPerformersRepository: ITopPerformersRepository) {
        self.leagueID = leagueID
        self.repository = repository
        self.fixtureRepository = fixtureRepository
        self.standingRepository = standingRepository
        self.topPerformersRepository = topPerformersRepository
        leagueId = leagueID
        Task{
            await getLeague()
        }
    }
    
    @Published var league: LeagueData?
    @Published var seasonList: [Season] = []
    @Published var selectedSeason: Season?
    @Published var currentSeason:Int = Date().year{
        didSet{
            selectedSeason = seasonList.first(where: {$0.year == currentSeason})
        }
    }
//    @Published var currentSeasonText:String{
//        return ""
//    }
    
     let leagueId:Int
    
    @MainActor
    func getLeague()async{
        do{
           
            league = try await repository.getLeagueById(id: leagueID)
            if let league = league{
                var list:[Season] = []
                list = league.seasons //.map({$0.year})
                
                list = list.sorted(by: { $0.year < $1.year })
                seasonList = list
                print("season list")
                print(list)
                
                if let season = seasonList.first(where: {$0.current == true}){
                    currentSeason = season.year
                    selectedSeason = season
                    
                   // await  getMatchList(season: season)
                    await  loadSeason()
                }
              
            }
           
            
        }
        catch{
            print("error is => \(error)")
        }
    }
    
    @Published var matchListWithChunked: Array<(key: String, value: Array<FixtureDataResponse>)> = []
    
    @Published var matchLoading :Bool = true
    @MainActor
    func getMatchList(season: Int) async {
        do {
            matchLoading = true
            let res: PaginationModel<FixtureDataResponse> = try await fixtureRepository.getMatchFixtureByLeagueID(league: leagueID, season: season)
            let matchList = res.list
            let tempCount = Dictionary(grouping: matchList) { fixtureResponse in
                let formatter = DateFormatter()
                formatter.dateFormat = "E, MMM d"
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                return formatter.string(from: fixtureResponse.fixture.date)
            }
            matchListWithChunked = tempCount.map({ (key: String($0.key), value: $0.value) })
            matchListWithChunked = matchListWithChunked.sorted { $0.key < $1.key }
        } catch {
            print("error is => \(error)")
        }
        matchLoading = false
    }
    
    
    @Published var standingsList: [Standing] = []
    
    @MainActor
    private func getSTandings()async{
        
        do{
            
            let list =   try await   standingRepository.getStandingByLeagueAndSeason(league: leagueId, season: currentSeason)
            
            standingsList = list
            
        }
        catch{
            print("error is \(error)")
        }
        
        
    }
    @Published var topScorerList:[PerformersResponse] = []
    @Published var topAssistList:[PerformersResponse] = []
    
    @MainActor
   private func getTopScorer()async{
        
        do{
            let list:[PerformersResponse] =  try await topPerformersRepository.getTopScorer(league: leagueId, season: currentSeason)
            topScorerList = list
            
        }catch{
            print("error is => \(error)")
        }
    }
    
    @MainActor
    private func getTopAssist()async{
        
        do{
            let list:[PerformersResponse] =  try await topPerformersRepository.getTopAssist(league: leagueId, season: currentSeason)
            topAssistList = list
            
        }catch{
            print("error is => \(error)")
        }
    }
    
    
    func loadSeason()async{
        Task{
            await getMatchList(season: currentSeason)
        }
        Task{
           // await getTopScorer()
        }
        Task{
           // await getTopAssist()
        }
        Task{
            await getSTandings()
        }
        
    }
}
