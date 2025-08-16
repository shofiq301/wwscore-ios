//
//  StatisticsRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect

public protocol IStatisticsRepository: Actor{
    
    func getStatics(fixture: Int )async throws ->[StatisticsResponse]
    
}

actor StatisticsRepository: IStatisticsRepository{
    
    private let client: ExHttpConnect
    
    init(client: ExHttpConnect){
        self.client = client
    }
    
    
    func getStatics(fixture: Int) async throws -> [StatisticsResponse] {
        do{
            var list: [StatisticsResponse] = []
            
            let res: AppResponse<TeamStaisticsResponse> = try await client.get("fixtures/statistics", headers: [:], query: ["fixture":"\(fixture)"])
            
         
            if let l = res.payload?.response{
                list = l
            }
            
            return list
        }
    }
    
    
}
