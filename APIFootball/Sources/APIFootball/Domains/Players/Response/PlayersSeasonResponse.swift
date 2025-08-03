//
//  PlayersSeasonResponse.swift
//  APIFootball
//
//  Created by Shahanul Haque on 7/12/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playersSeasonResponse = try? JSONDecoder().decode(PlayersSeasonResponse.self, from: jsonData)

import Foundation

// MARK: - PlayersSeasonResponse
struct PlayersSeasonResponse: Codable, Sendable {
    let status: Bool
    let message: String
    let data: PlayersSeasonDataClass
}

// MARK: - DataClass
struct PlayersSeasonDataClass: Codable, Sendable {
    
    let response: [Int]

    enum CodingKeys: String, CodingKey {
       
        case response
    }
}



