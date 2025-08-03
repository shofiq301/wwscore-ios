//
//  LeagueResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leaguesResponse = try? JSONDecoder().decode(LeaguesResponse.self, from: jsonData)

import Foundation

// MARK: - LeaguesResponse
struct LeaguesResponse: Codable,Sendable {
    let response: [LeagueData]

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
public struct LeagueData: Codable, Sendable{
    public let league: LeagueDetailsData
    public let country: Country
    public let seasons: [Season]
    
    public func getCurrentSeason() -> Season? {
        return seasons.first(where: {$0.current == true}) ?? seasons.first
    }

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case country = "country"
        case seasons = "seasons"
    }
}

// MARK: - Country
public struct Country: Codable, Sendable {
    public let name: String
    public let code: String?
    public let flag: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case code = "code"
        case flag = "flag"
    }
    
    public init(name: String, code: String?, flag: String?) {
        self.name = name
        self.code = code
        self.flag = flag
    }
}

// MARK: - League
public struct LeagueDetailsData: Codable, Sendable {
    public let id: Int
    public let name: String
    public let type: TypeEnum
    public let logo: String
    
    public  init(id: Int, name: String, type: TypeEnum, logo: String) {
        self.id = id
        self.name = name
        self.type = type
        self.logo = logo
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case logo = "logo"
    }
}

public enum TypeEnum: String, Codable, Sendable {
    case cup = "Cup"
    case league = "League"
}

// MARK: - Season
public struct Season: Codable, Sendable {
    public let year: Int
    public let start: String?
    public let end: String?
    public let current: Bool
    
    public var seasonName: String {
        guard let start = start, let end = end else {
            return ""
        }
        let startYear = String(start.prefix(4))
        let endYear = String(end.prefix(4))
        
        if let startShort = Int(startYear).map({ $0 % 100 }),
           let endShort = Int(endYear).map({ $0 % 100 }) {
            return String(format: "%02d/%02d", startShort, endShort)
        } else {
            return "\(start)-\(end)"
        }
    }

    enum CodingKeys: String, CodingKey {
        case year = "year"
        case start = "start"
        case end = "end"
        case current = "current"
    }
}

