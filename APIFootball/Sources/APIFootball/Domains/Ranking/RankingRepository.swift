//
//  RankingRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect

public protocol IRankingRepository: Actor{
    
    func getFifaRanking()async throws -> [RankingData]
    func getUefaRanking()async throws -> [RankingData]
    func getPlayersTransfer()async throws -> [TransferData]
}

actor RankingRepository: IRankingRepository{
    let client: ExHttpConnect
    
    init(client: ExHttpConnect) {
        self.client = client
    }
    
    
    func getFifaRanking() async throws -> [RankingData] {
        do{
            var list: [RankingData] = []
            
            let res: AppResponse<RankingResponse> = try await client.get("rank/fifa", headers: [:], query: [:])
            
            if let l = res.payload?.data{
                list = l
            }
            return list
        }
    }
    
    
    func getUefaRanking() async throws -> [RankingData] {
        do{
            var list: [RankingData] = []
            
            let res: AppResponse<RankingResponse> = try await client.get("rank/uefa", headers: [:], query: [:])
            
            if let l = res.payload?.data{
                list = l
            }
            return list
        }
    }
    
    func getPlayersTransfer() async throws -> [TransferData] {
        var list: [TransferData] = []
        
        let res: AppResponse<TransferResponse> = try await client.get("transfer-list", headers: [:], query: [:])
        
        if let l = res.payload?.data{
            list = l
        }
        return list
    }
}
