//
//  TrophiesResponse.swift
//  APIFootball
//
//  Created by Shahanul Haque on 7/13/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trophiesResponse = try? JSONDecoder().decode(TrophiesResponse.self, from: jsonData)

import Foundation

// MARK: - TrophiesResponse
struct TrophiesResponse: Codable, Sendable {
    let status: Bool
    let message: String
    let data: TrophiesDataClass
}

// MARK: - DataClass
struct TrophiesDataClass: Codable, Sendable {
   
    let response: [TrophiesData]

    enum CodingKeys: String, CodingKey {
       
        case  response
    }
}

// MARK: - Response
public struct TrophiesData: Codable, Sendable, Identifiable {
    public let id: String  = UUID().uuidString
    public  let league: String
    public let country: String
    public let season: String
    public let place: String
}
