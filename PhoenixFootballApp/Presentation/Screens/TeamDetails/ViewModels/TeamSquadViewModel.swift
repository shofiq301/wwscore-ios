//
//  TeamSquadViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/27/25.
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


final class TeamSquadViewModelBindings:IBindings{
    
    let teamID:Int
    
    init(teamID: Int) {
        self.teamID = teamID
    }
    
    func getDependency() -> TeamSquadViewModel {
        do{
            let viewModel = try? SmartDI.DI.resolve(TeamSquadViewModel.self, name: "team_\(teamID)", scope: nil)
            
            if let viewModel = viewModel {
              return  viewModel
            }else{
                
              
                let teamRepository = TeamRepositoryBindings().getDependency()
                let viewModel = TeamSquadViewModel(teamRepository: teamRepository)
                SmartDI.DI.register( TeamSquadViewModel.self , name: "team_\(teamID)") { r in
                    viewModel
                }
                return viewModel
            }
            
        }
    }
}

final class TeamSquadViewModel:ObservableObject{
    let teamRepository: ITeamRepository
    
    init(teamRepository: ITeamRepository) {
        self.teamRepository = teamRepository
    }
    
    @Published var teamSquad: [SquadPlayer] = []
    @Published var teamSquadBy: [ String : [SquadPlayer]] = [:]
    
    @MainActor
    func getTeamSquad(teamId: Int) async  {
        do{
            teamSquad = try await teamRepository.getTeamSquardsByTeamID(id: teamId)
           let groupedBy = teamSquad.group(by: { v in
                v.position.rawValue
            })
            
            teamSquadBy = groupedBy
            
        }catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
}
