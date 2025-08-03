//
//  MatchListViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 4/22/25.
//

import SwiftUI
import APIFootball
import EasyXConnect
import EasyX
import XSwiftUI
final class MatchListViewModelBindings:IBindings{
    
    func getDependency() -> MatchListViewModel {
        if let viewModel = try? DIContainer.shared.resolve(MatchListViewModel.self){
            return viewModel
        }
        let viewModel = MatchListViewModel(repository: FixtureRepositoryBindings().getDependency())
        
        DIContainer.shared.register(MatchListViewModel.self) { _ in viewModel }
        return viewModel
        
    }
}

final class MatchListViewModel:ObservableObject{
    
    let repository: IFixtureRepository
    
    init(repository: IFixtureRepository) {
        self.repository = repository
    }
    
    @Published var fixtureList:[FixtureDataResponse] = []
    @Published private(set) var fixtureListByLeague: [(String, [FixtureDataResponse])] = []
    
    @MainActor
    func getMatchesByDate(date:Date) async  {
        do{
            let res = try await repository.getMatchFixtureByDate(date: date)
            
            fixtureList = res.list
//          let res = try await repository.getOnGoingMatchs()
            fixtureListByLeague = groupFixturesByPriorityCountry(from: fixtureList)
           // AppLogger.log(res.list.toJSONString(prettyPrinted: true) ?? "")
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
    
}
