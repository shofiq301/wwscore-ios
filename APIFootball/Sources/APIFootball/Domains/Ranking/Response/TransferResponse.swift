//
//  TransferResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let transferResponse = try? JSONDecoder().decode(TransferResponse.self, from: jsonData)

import Foundation

// MARK: - TransferResponse
struct TransferResponse: Codable, Sendable {
    let status: Bool
    let data: [TransferData]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - Datum
public struct TransferData: Codable, Identifiable, Sendable {
    public let id: Int
    public let playerID: Int
    public let teamID: Int
    public let player: TransferPlayer
    public let playerDetails: PlayerDetails?
    public let info: TransferInfo
    public let dealDate: String
   

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case playerID = "player_id"
        case teamID = "club_id"
        case player = "player"
        case info = "info"
        case dealDate = "deal_date"
        case playerDetails = "player_details"
      
    }
}


// MARK: - Info
public struct TransferInfo: Codable, Sendable {
    public let date: String
    public let type: String?
    public let teams: TransferTeam

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case type = "type"
        case teams = "teams"
    }
}

// MARK: - Teams
public struct TransferTeam: Codable, Sendable {
    public let teamsIn: TransferPlayer
    public let out: TransferPlayer

    enum CodingKeys: String, CodingKey {
        case teamsIn = "in"
        case out = "out"
    }
}

// MARK: - PlayerDetails
public struct TransferPlayer: Codable, Sendable {
    public let id: Int
    public let name: String
    public let logo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
}
// MARK: - PlayerDetails
public struct PlayerDetails: Codable, Sendable {
    public let id: Int
    public let name: String
    public let firstname: String?
    public let lastname: String?
    public let age: Int
    public let birth: PlayerBirth
    public let nationality: String?
    public let height: String?
    public let weight: String?
    public let injured: Bool
    public let photo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case firstname = "firstname"
        case lastname = "lastname"
        case age = "age"
        case birth = "birth"
        case nationality = "nationality"
        case height = "height"
        case weight = "weight"
        case injured = "injured"
        case photo = "photo"
    }
}

// MARK: - Birth
public struct PlayerBirth: Codable, Sendable {
    public let date: String?
    public let place: String?
    public let country: String?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case place = "place"
        case country = "country"
    }
}
