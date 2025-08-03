//
//  TeamSquadsResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamSquadsResponse = try? JSONDecoder().decode(TeamSquadsResponse.self, from: jsonData)

import Foundation

// MARK: - TeamSquadsResponse
struct TeamSquadsResponse: Codable, Sendable {
    let response: [SquadResponse]

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
public struct SquadResponse: Codable, Sendable {
    public let team: SquadTeam
    public  let players: [SquadPlayer]

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case players = "players"
    }
}

// MARK: - Player
public struct SquadPlayer: Codable, Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let age: Int?
    public let number: Int?
    public let position: Position
    public let photo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case age = "age"
        case number = "number"
        case position = "position"
        case photo = "photo"
    }
}

public enum Position: String, Codable, Sendable {
    case attacker = "Attacker"
    case defender = "Defender"
    case goalkeeper = "Goalkeeper"
    case midfielder = "Midfielder"
}

//// MARK: - Team
public struct SquadTeam: Codable, Sendable {
    public let id: Int
    public let name: String
    public let logo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
}
