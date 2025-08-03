//
//  FixtureKeyEventRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect

public protocol IFixtureKeyEventRepository:Actor{
    func getEventsByfixture(fixture:Int)async throws -> [FixtureKeyEventsData]
}

actor FixtureKeyEventRepository: IFixtureKeyEventRepository{
    
    private let client: ExHttpConnect
    
    init(client: ExHttpConnect){
        self.client = client
    }
    
    
    func getEventsByfixture(fixture: Int) async throws -> [FixtureKeyEventsData] {
        do{
            var list: [FixtureKeyEventsData] = []
            
            let query:[String:String] = ["fixture":"\(fixture)"]
            
            let res:AppResponse<GenericNetworkModel<FixtureKeyEventsResponse>> = try await client.get("fixtures/events", headers: [:], query: query)
            
            if let l = res.payload?.data?.response {
                list  = l
            }

            return list
            
        }
    }
}
