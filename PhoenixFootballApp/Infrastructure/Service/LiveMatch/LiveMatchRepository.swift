//
//  LiveMatchRepository.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/27/25.
//
import Foundation
import APIFootball
import EasyX
import EasyXConnect

actor LiveMatchRepository{
    private let client: ExHttpConnect

    init(client: ExHttpConnect) {
      self.client = client
    }
    
    
    func getALlLiveMatch() async throws -> [FixtureDataResponse] {
        do{
            let response: AppResponse<LiveMatchResponse> = try await client.get("user/match/list", query: nil)
            
            if let payload = response.payload?.data{
                return payload
            }
            
            throw NotFoundException(message: response.payload?.message ??  "something went wrong")
        }
    }
}
