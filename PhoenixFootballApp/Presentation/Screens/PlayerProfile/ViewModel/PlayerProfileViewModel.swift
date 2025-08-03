//
//  PlayerProfileViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/8/25.
//

import Foundation
import XSwiftUI
import EasyX
import PhoenixUI
import APIFootball
import EasyXConnect

final class PlayerProfileViewModelBindings:IBindings{
    
    
    func getDependency() -> PlayerProfileViewModel {
        
        if let viewModel = try? SmartDI.DI.resolve(PlayerProfileViewModel.self, name: nil, scope: nil){
            return viewModel
        }
        
        let palyerRepo: IPlayerProfileRepository = PlayerProfileRepositoryBindings().getDependency()
        let trophiesRepo: ITrophiesRepository = TrophiesRepositoryBindings().getDependency()
        let viewModel: PlayerProfileViewModel = PlayerProfileViewModel(repository: palyerRepo, trophiesRepository: trophiesRepo)
        
        
        SmartDI.DI.register(PlayerProfileViewModel.self, name: nil, factory: { _ in  viewModel})
        
        return viewModel
        
    }
}


final class PlayerProfileViewModel:ObservableObject{
    
    let repository: IPlayerProfileRepository
    let trophiesRepository: ITrophiesRepository
    
    
    init(repository: IPlayerProfileRepository, trophiesRepository: ITrophiesRepository) {
        self.repository = repository
        self.trophiesRepository = trophiesRepository
    }
    
    
    @Published var player:PlayerModel?
    @Published var playerTeam:Team?
    
    @Published var statistics: [PlayerStatistic] = []
    @Published var trophies: [TrophiesData] = []
    @Published var trophiesBySeason: Array<(key: String, value: Array<TrophiesData>)> = []
    @Published var seasons:[Int] = []
    
    
    @MainActor
    func getPlayerData(playerID:Int, season: Int)async{
        
        
        do{
//            let res  = try await repository.getPlayerStatisticsByID(playerID: playerID, season: season)
//            let res  = try await repository.getPlayerProfileByID(playerID: playerID, season: season)
            let res  = try await repository.getPlayerProfileByID(playerID: playerID)
            if let data = res.first{
                player = data
//                statistics = data.statistics
            }
            
        }catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
    
    @MainActor
    func getPlayerSeasons(playerID:Int)async{
        do{
            let res  = try await repository.getPlayersSeasonByID(playerID: playerID)
            seasons = res
            
        }catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
    
    
    @MainActor
    func getPlayerSquards(playerID:Int)async{
        do{
            let res  = try await repository.getPlayerSquads(playerID: playerID)
            playerTeam = res.last?.team
            
        }catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
    
    func getLatestSeason() -> Int? {
        return seasons.max()
    }
    
    @MainActor
    func getPlayersTrophies(playerID: Int) async {
        do {
            let res = try await trophiesRepository.getTrophiesByPlayerID(playerID: playerID)
            trophies = res.filter({$0.place == "Winner"})
            trophiesBySeason = Dictionary(grouping: trophies, by: { $0.season }).sorted { $0.key > $1.key }
        } catch {
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
}
