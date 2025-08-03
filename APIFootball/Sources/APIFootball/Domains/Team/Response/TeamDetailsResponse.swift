//
//  TeamDetailsResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation

//   let teamDetailsResponse = try? JSONDecoder().decode(TeamDetailsResponse.self, from: jsonData)


// MARK: - TeamDetailsResponse
struct TeamDetailsResponse: Codable, Sendable {
    let response: [TeamsResponse]

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
public struct TeamsResponse: Codable, Sendable {
    public let team: TeamInfoData
    public let venue: VenueData

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case venue = "venue"
    }
}

// MARK: - Team
public struct TeamInfoData: Codable, Sendable {
    public let id: Int
    public let name: String
    public let code: String?
    public let country: String
    public let founded: Int?
    public let national: Bool
    public let logo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case code = "code"
        case country = "country"
        case founded = "founded"
        case national = "national"
        case logo = "logo"
    }
}

//// MARK: - Venue
//struct Venue: Codable {
//    let id: Int?
//    let name: String?
//    let address: String?
//    let city: String?
//    let capacity: Int?
//    let surface: String?
//    let image: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case address = "address"
//        case city = "city"
//        case capacity = "capacity"
//        case surface = "surface"
//        case image = "image"
//    }
//}
