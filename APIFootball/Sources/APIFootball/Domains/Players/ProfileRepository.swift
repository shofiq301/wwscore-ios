//
//  ProfileRepository.swift
//  APIFootball
//
//  Created by Shahanul Haque on 7/7/25.
//

import EasyXConnect
import Foundation

public protocol IPlayerProfileRepository: Actor {

  //V3 - Players Profiles
  func getPlayerProfileByID(playerID: Int) async throws -> [PlayerModel]
  // Players statistics by player id
    func getPlayerStatisticsByID(playerID: Int, season: Int) async throws -> [PlayersStatisticsResponseModel]
    
    func getPlayersSeasonByID(playerID:Int) async throws ->[Int]
    func getPlayerSquads(playerID:Int) async throws -> [PlayersSquadsData]

}

actor PlayerProfileRepository: IPlayerProfileRepository {
   
    
  

  let client: ExHttpConnect

  init(client: ExHttpConnect) {
    self.client = client
  }

  func getPlayerProfileByID(playerID: Int) async throws -> [PlayerModel] {
    do {
        var list: [PlayerModel] = []
        
        let res: AppResponse<GenericNetworkModel<PlayerDataClass>> = try await client.get("players/profiles", headers: [:], query: [
            //"season":"\(season)" ,
            "player": "\(playerID)"])
     
        if let l = res.payload?.data?.response{
            list = l.map({$0.player})
        }
        
        return list
    }
  }

  func getPlayerStatisticsByID(playerID: Int, season: Int) async throws -> [PlayersStatisticsResponseModel] {
    do {
        var list: [PlayersStatisticsResponseModel] = []
        
        let res: AppResponse<GenericNetworkModel<PlayersStatisticsDataClass>> = try await client.get("players", headers: [:], query: ["season":"\(season)" , "id": "\(playerID)"])
     
        if let l = res.payload?.data?.response{
            list = l
        }
        
        return list
    }
  }

    func getPlayersSeasonByID(playerID: Int) async throws -> [Int] {
        do {
            var seasons: [Int] = []
            
            let res: AppResponse<GenericNetworkModel<PlayersSeasonDataClass>> = try await client.get("players/seasons", headers: [:], query: [ "player": "\(playerID)"])
         
            if let l = res.payload?.data?.response{
                seasons = l
            }
            
            return seasons
        }
    }
    
    func getPlayerSquads(playerID: Int) async throws -> [PlayersSquadsData] {
        var list: [PlayersSquadsData] = []
        
        let res: AppResponse<GenericNetworkModel<PlayersSquadsDataClass>> = try await client.get("players/squads", headers: [:], query: [
            //"season":"\(season)" ,
            "player": "\(playerID)"])
     
        if let l = res.payload?.data?.response{
            list = l
        }
        
        return list
    }
    
}
