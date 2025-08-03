//
//  HomeViewModels.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 4/24/25.
//

import SwiftUI
import APIFootball
import EasyXConnect
import EasyX
import XSwiftUI
final class HomeViewModelBindings:IBindings{
    
    func getDependency() -> HomeViewModel {
        if let viewModel = try? DIContainer.shared.resolve(HomeViewModel.self){
            return viewModel
        }
        let viewModel = HomeViewModel(repository: FixtureRepositoryBindings().getDependency())
        
        DIContainer.shared.register(HomeViewModel.self) { _ in viewModel }
        return viewModel
        
    }
}

final class HomeViewModel:ObservableObject{
   private let repository: IFixtureRepository
    
    init(repository: IFixtureRepository) {
        self.repository = repository
    }
    @Published var fixtureList:[FixtureDataResponse] = []
    @Published var highlightedFixtureList:[FixtureDataResponse] = []
    @Published private(set) var fixtureListByLeague: [(String, [FixtureDataResponse])] = []
    
    @MainActor
    func getMatchesByDate(date:Date) async  {
        do{
            let res = try await repository.getMatchFixtureByDate(date: date)
            
            fixtureList = res.list
//          let res = try await repository.getOnGoingMatchs()
            fixtureListByLeague = groupFixturesByPriorityCountry(from: fixtureList)
           // AppLogger.log(res.list.toJSONString(prettyPrinted: true) ?? "")
            highlightedFixtureList = getHighlightedFixtures()
        }
        catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
         
    }

    private func groupFixturesByPriorityCountry(from fixtures: [FixtureDataResponse]) -> [(String, [FixtureDataResponse])] {
        let grouped = Dictionary(grouping: fixtures, by: { $0.league.name })

        let priorityLeagues = [ "La Liga", "Premier League","Bundesliga", "Serie A", "Ligue 1", "Eredivisie", "Primeira Liga"]
        var sortedSections: [(String, [FixtureDataResponse])] = []

        // 1. Add prioritized leagues first
        for league in priorityLeagues {
            if let fixtures = grouped[league] {
                let sorted = fixtures.sorted { $0.league.name < $1.league.name }
                sortedSections.append((league, sorted))
            }
        }

        // 2. Add the rest alphabetically
        let otherLeagues = grouped.keys
            .filter { !priorityLeagues.contains($0) }
            .sorted()

        for league in otherLeagues {
            if let fixtures = grouped[league] {
                let sorted = fixtures.sorted { $0.league.name < $1.league.name }
                sortedSections.append((league, sorted))
            }
        }

        return sortedSections
    }
    
    
    // Return high-voltage (rivalry) matches first, then high-profile club matches, else priority leagues fallback
    func getHighlightedFixtures() -> [FixtureDataResponse] {
        // Define rivalry pairs
        let rivalries: [Set<String>] = [
            Set(["Barcelona", "Real Madrid"]),
            Set(["Manchester United", "Liverpool"]),
            Set(["AC Milan", "Inter Milan"]),
            Set(["Boca Juniors", "River Plate"]),
            Set(["Celtic", "Rangers"]),
            Set(["Real Madrid", "Atletico Madrid"]),
            Set(["Borussia Dortmund", "Bayern Munich"]),
            Set(["Galatasaray", "Fenerbahçe"]),
            Set(["Ajax", "Feyenoord"]),
            Set(["Arsenal", "Tottenham Hotspur"]),
            Set(["Paris Saint-Germain", "Marseille"])
        ]
        // Define high-profile clubs
        let highProfileClubs: Set<String> = [
            "Barcelona", "Real Madrid", "Manchester United",
            "Liverpool", "Bayern Munich", "Juventus",
            "AC Milan", "Inter Milan", "Paris Saint-Germain",
            "Manchester City", "Chelsea", "Arsenal",
            "Borussia Dortmund", "Atletico Madrid", "Tottenham Hotspur",
            "Napoli", "Ajax", "Benfica", "Porto",
            "Sevilla", "Valencia", "Roma", "Lazio",
            "Monaco", "RB Leipzig"
        ]
        // 1. Check for direct rivalry matches
        let rivalryMatches = fixtureList.filter { fixture in
            let home = fixture.teams.home.name
            let away = fixture.teams.away.name
            for pair in rivalries {
                if pair.contains(home) && pair.contains(away) {
                    return true
                }
            }
            return false
        }
        if !rivalryMatches.isEmpty {
            return Array(rivalryMatches.prefix(10))
        }
        // 2. Highlight matches featuring any high-profile club
        let highProfileMatches = fixtureList.filter { fixture in
            let home = fixture.teams.home.name
            let away = fixture.teams.away.name
            return highProfileClubs.contains(home) || highProfileClubs.contains(away)
        }
        if !highProfileMatches.isEmpty {
            return Array(highProfileMatches.prefix(10))
        }
        // 3. Fallback: matches from priority leagues, sorted by priority order
        let priorityLeagues: [String] = [
            "La Liga", "Premier League", "Bundesliga",
            "Serie A", "Ligue 1"
        ]
        let fallbackMatches = fixtureList.filter { priorityLeagues.contains($0.league.name) }
        let sortedFallback = fallbackMatches.sorted { first, second in
            guard let firstIndex = priorityLeagues.firstIndex(of: first.league.name),
                  let secondIndex = priorityLeagues.firstIndex(of: second.league.name) else {
                return false
            }
            return firstIndex < secondIndex
        }
        return Array(sortedFallback.prefix(10))
        
    }
}
