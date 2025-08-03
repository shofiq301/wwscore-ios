//
//  VenuesRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect

public protocol IVenuesRepository: Actor{
    
    func getVenueByID(id:Int) async throws -> VenueData
    func getVenueByCountry(name:String) async throws -> [VenueData]
    
}

public enum VenueException: Error {
    case VenueNotFound
}

actor VenuesRepository: IVenuesRepository{
    let client: ExHttpConnect
    
    init(client: ExHttpConnect) {
        self.client = client
    }
    
    func getVenueByID(id: Int) async throws -> VenueData {
        do{
            
            let query = ["id": "\(id)"]
            let res: AppResponse<GenericNetworkModel<VenuesResponse>>  =  try await  client.get("venues", headers: [:], query: query)
            
            if let venue =  res.payload?.data?.response.first{
                return venue
            }
            
            throw VenueException.VenueNotFound
        }
    }
    
    
    func getVenueByCountry(name: String) async throws -> [VenueData] {
        do{
            var list : [VenueData] = []
            let query = ["country": "\(name)"]
            let res: AppResponse<GenericNetworkModel<VenuesResponse>>  =  try await  client.get("venues", headers: [:], query: query)
            
            if let venues =  res.payload?.data?.response{
                list =  venues
            }
            
          return list
        }
    }
}
