//
//  TeamMatchListViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/7/25.
//


import SwiftUI
import APIFootball
import EasyXConnect
import EasyX
import XSwiftUI

final class TeamMatchListViewModelBindings:IBindings{
    
    func getDependency() -> TeamMatchListViewModel {
        if let viewModel = try? SmartDI.DI.resolve(TeamMatchListViewModel.self, name: nil, scope: nil){
            return viewModel
        }
        let viewModel = TeamMatchListViewModel(repository: FixtureRepositoryBindings().getDependency())
        
        SmartDI.DI.register(TeamMatchListViewModel.self, name: nil) { _ in viewModel }
        return viewModel
        
    }
}

final class TeamMatchListViewModel:ObservableObject{
    
    let repository: IFixtureRepository
    
    init(repository: IFixtureRepository) {
        self.repository = repository
    }
    
    @Published var fixtureList:[FixtureDataResponse] = []
    @Published var last5FixtureList:[FixtureDataResponse] = []
    @Published private(set) var fixtureListByLeague: [(String, [FixtureDataResponse])] = []
    
    @Published var nextMatch:FixtureDataResponse?
    
    @MainActor
    func getMatchesByTeam(teamID:Int , season:Int) async  {
        do{
            let res = try await repository.getMatchFixtureByteamID(id: teamID, season: season)
            
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
    
    
    @MainActor
    func getLast5Fixture(teamID:Int ) async  {
        do{
            let res = try await repository.getLastXMatchFixtureByteamID(id: teamID, last: 5)
            
            last5FixtureList = res.list

        }
        catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
         
    }
    
    @MainActor
    func getnextFixture(teamID:Int ) async  {
        do{
            let res = try await repository.getNextNMatchFixtureByteamID(id: teamID, next: 1)
            
            nextMatch = res.list.first

        }
        catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
         
    }
}
