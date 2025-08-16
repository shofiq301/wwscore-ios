//
//  LineUpsRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect


public protocol ILineUPRepository: Actor{
    func getLineUps(fixtureId: Int)async throws -> [LineUpsData]
}


actor LineUpRepository: ILineUPRepository{
    
    private let client: ExHttpConnect
    
    init(client: ExHttpConnect){
        self.client = client
    }
    
    
    func getLineUps(fixtureId: Int)async throws -> [LineUpsData]{
        
        var list:[LineUpsData] = []
        
        do{
            let res: AppResponse<FixtureLineUPResponse> =  try await  client.get("fixtures/lineups", headers: [:], query: ["fixture":"\(fixtureId)"])
            if let l = res.payload?.response{
                list = l
            }
        }
        
        return list
        
    }
    
    
}
