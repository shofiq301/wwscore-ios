//
//  GenericNetworkModel.swift
//  APIFootball
//
//  Created by Shahanul Haque on 4/20/25.
//

import Foundation

public struct GenericNetworkModel<T: Codable>: Codable, Sendable where T: Sendable {
    public let message: String?
  
    public let data: T?
    public let status: Bool?
    
    public init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<GenericNetworkModel<T>.CodingKeys> =
        try decoder.container(keyedBy: GenericNetworkModel<T>.CodingKeys.self)
       
        
        self.message = try container.decodeIfPresent(
            String.self, forKey: GenericNetworkModel<T>.CodingKeys.message)
        self.data = try container.decodeIfPresent(
            T.self, forKey: GenericNetworkModel<T>.CodingKeys.data)
        self.status = try container.decodeIfPresent(
            Bool.self, forKey: GenericNetworkModel<T>.CodingKeys.status)
    }
    
    public init(message: String?, data: T?, status: Bool?) {
        self.message = message
        self.data = data
        self.status = status
     
    }
    
}

