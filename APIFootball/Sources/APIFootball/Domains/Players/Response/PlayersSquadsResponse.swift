//
//  PlayersSquadsResponse.swift
//  APIFootball
//
//  Created by Shahanul Haque on 7/13/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playersSquadsResponse = try? JSONDecoder().decode(PlayersSquadsResponse.self, from: jsonData)

import Foundation

// MARK: - PlayersSquadsResponse
struct PlayersSquadsResponse: Codable, Sendable {
    let status: Bool
    let message: String
    let data: PlayersSquadsDataClass
}

// MARK: - DataClass
struct PlayersSquadsDataClass: Codable, Sendable {
  
    let response: [PlayersSquadsData]

    enum CodingKeys: String, CodingKey {
      
        case  response
    }
}


// MARK: - Response
public struct PlayersSquadsData: Codable, Sendable {
   public let team: Team
   public let players: [Player]
}
