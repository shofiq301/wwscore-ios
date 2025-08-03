//
//  TeamDetailsViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/23/25.
//


import SwiftUI
import APIFootball
import XSwiftUI
import EasyXConnect
import EasyX
import SwifterSwift
import SDWebImageSwiftUI
import SDWebImage
import SUIRouter
import PhoenixUI


final class TeamDetailsViewModelBindings:IBindings{
    
    let teamID:Int
    
    init(teamID: Int) {
        self.teamID = teamID
    }
    
    func getDependency() -> TeamDetailsViewModel {
        do{
            let viewModel = try? SmartDI.DI.resolve(TeamDetailsViewModel.self, name: "team_\(teamID)", scope: nil)
            
            if let viewModel = viewModel {
              return  viewModel
            }else{
                
                let repository = FixtureRepositoryBindings().getDependency()
                let teamRepository = TeamRepositoryBindings().getDependency()
                let stRepository = StandingsRepositoryBindings().getDependency()
                let viewModel = TeamDetailsViewModel(fixtureRepository: repository, teamRepository: teamRepository, standingRepository: stRepository)
                SmartDI.DI.register( TeamDetailsViewModel.self , name: "team_\(teamID)") { r in
                    viewModel
                }
                return viewModel
            }
            
        }
    }
}

final class TeamDetailsViewModel:ObservableObject{
    private let fixtureRepository:IFixtureRepository
    private let teamRepository: ITeamRepository
    private let standingRepository: IStandingRepository
    
    
    init(fixtureRepository: IFixtureRepository, teamRepository: ITeamRepository, standingRepository: IStandingRepository) {
        self.fixtureRepository = fixtureRepository
        self.teamRepository = teamRepository
        self.standingRepository = standingRepository
    }
    
    @Published var teamInfo: TeamInfoData?
    
    @MainActor
    func getTeamInfo(id: Int)async{
        do{
            
         let res = try await teamRepository.getTeamByID(id: id)
            teamInfo = res.first?.team
            
            
        }catch{}
    }
    
    @Published var standingsList: [StandingResponse] = []
    
    @MainActor
     func getSTandings(team: Int, currentSeason: Int)async{
        
        do{
            
            let list =   try await   standingRepository.getStandingByTeamAndSeason(team: team, season: currentSeason)
            
            standingsList = list
            
        }
        catch{
            print("error is \(error)")
        }
        
        
    }
    
    
    @Published var fixtureList:[FixtureDataResponse] = []
    @Published private(set) var fixtureListByLeague: [(String, [FixtureDataResponse])] = []
    
    @MainActor
    func getFixtureByTeam(team: Int, currentSeason: Int)async{
        do{
            let res = try await fixtureRepository.getMatchFixtureByteamID(id: team, season: currentSeason)
            
            fixtureList = res.list
        }
        catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
}
