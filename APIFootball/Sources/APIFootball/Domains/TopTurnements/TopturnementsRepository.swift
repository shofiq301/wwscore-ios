//
//  TopturnementsRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect

public protocol ITopTurnementsRepository:Actor{
    func getTopLeagues()async throws -> [TurnementsData]
    func getTopTurnements()async throws -> [TurnementsData]
}
actor TopTurnementsRepository: ITopTurnementsRepository{
    
    let client: ExHttpConnect
    
    init(client: ExHttpConnect) {
        self.client = client
    }
    
    
    func getTopLeagues() async throws -> [TurnementsData] {
        
        do{
            var list: [TurnementsData] =  []
            let query:[String:String] = ["type":"League"]
            
            let res: AppResponse<TopTurnementsResponse> = try await client.get("top-tournaments", headers: [:], query: query)
            
            if let l = res.payload?.data{
                 list = l
            }

            return list

            
        }
    }
    
    
    func getTopTurnements() async throws -> [TurnementsData] {
        do{
            var list: [TurnementsData] =  []
            let query:[String:String] = ["type":"Cup"]
            
            let res: AppResponse<TopTurnementsResponse> = try await client.get("top-tournaments", headers: [:], query: query)
            
            if let l = res.payload?.data{
                 list = l
            }

            return list

            
        }
    }
    
    
}
