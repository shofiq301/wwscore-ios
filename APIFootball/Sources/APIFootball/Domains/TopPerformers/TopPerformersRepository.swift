//
//  TopPerformersRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect

public protocol ITopPerformersRepository: Actor{
    
    func getTopScorer(league: Int, season:Int)async throws -> [PerformersResponse]
    func getTopAssist(league: Int, season:Int)async throws -> [PerformersResponse]
}


actor TopPerformersRepository: ITopPerformersRepository{
    
    private let client: ExHttpConnect
    
    init(client: ExHttpConnect){
        self.client = client
    }
    
    func getTopScorer(league: Int, season: Int)async throws -> [PerformersResponse] {
        do{
            var list:[PerformersResponse] = []
            let query:[String:String] = [
                "league": "\(league)",
                "season": "\(season)"
            ]
            let res:AppResponse<TopPerformersResponse>  =  try await client.get("players/topscorers", headers: [:], query: query)
            
            if let l = res.payload?.response{
                list = l
            }
            
            return list
            
        }
    }
    
    
    func getTopAssist(league: Int, season: Int) async throws -> [PerformersResponse] {
        do{
            var list:[PerformersResponse] = []
            let query:[String:String] = [
                "league": "\(league)",
                "season": "\(season)"
            ]
            let res:AppResponse<TopPerformersResponse>  =  try await client.get("players/topassists", headers: [:], query: query)
            
            if let l = res.payload?.response{
                list = l
            }
            
            return list
            
        }
    }
}
