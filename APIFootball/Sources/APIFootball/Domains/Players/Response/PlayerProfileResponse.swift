// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playerProfileResponse = try? JSONDecoder().decode(PlayerProfileResponse.self, from: jsonData)

import Foundation

// MARK: - PlayerProfileResponse
public struct PlayerProfileResponse: Codable, Sendable {
    public let status: Bool
    public let message: String
    public let data: PlayerDataClass

    public init(status: Bool, message: String, data: PlayerDataClass) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - PlayerDataClass
public struct PlayerDataClass: Codable, Sendable {
    public let results: Int
    public let paging: Paging
    public let response: [PlayerResponse]

    public init(results: Int, paging: Paging, response: [PlayerResponse]) {
        self.results = results
        self.paging = paging
        self.response = response
    }
}

// MARK: - PlayerResponse
public struct PlayerResponse: Codable, Sendable {
    public let player: PlayerModel

    public init(player: PlayerModel) {
        self.player = player
    }
}

// MARK: - PlayerModel
public struct PlayerModel: Codable, Sendable {
    public let id: Int
    public let name, firstname, lastname: String
    public let age: Int
    public let birth: Birth
    public let nationality, height, weight: String
    public let number: Int?
    public let position: String?
    public let photo: String

    public init(
        id: Int,
        name: String,
        firstname: String,
        lastname: String,
        age: Int,
        birth: Birth,
        nationality: String,
        height: String,
        weight: String,
        number: Int?,
        position: String?,
        photo: String
    ) {
        self.id = id
        self.name = name
        self.firstname = firstname
        self.lastname = lastname
        self.age = age
        self.birth = birth
        self.nationality = nationality
        self.height = height
        self.weight = weight
        self.number = number
        self.position = position
        self.photo = photo
    }
}
