// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topPerformersResponse = try? JSONDecoder().decode(TopPerformersResponse.self, from: jsonData)

import Foundation

// MARK: - TopPerformersResponse
struct TopPerformersResponse: Codable, Sendable {
    let response: [PerformersResponse]

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
public struct PerformersResponse: Codable, Sendable {
    public let player: TopPlayer
    public let statistics: [PerformersStatistic]

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case statistics = "statistics"
    }
}

// MARK: - Player
public struct TopPlayer: Codable, Sendable {
    public let id: Int
    public let name: String
    public let firstname: String
    public let lastname: String
    public let age: Int
    public let birth: Birth
    public let nationality: String
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
public struct Birth: Codable, Sendable {
    public let date: String?
    public let place: String?
    public let country: String?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case place = "place"
        case country = "country"
    }
}

// MARK: - Statistic
public struct PerformersStatistic: Codable, Sendable {
    public let team: Team
    public let league: ScorerLeague
    public let games: ScorerGames
    public let substitutes: Substitutes
    //let shots: ScorerShots
    public let goals: ScorerGoals
    public let passes: ScorerPasses
    public let tackles: Tackles
    public let duels: ScorerDuels
    public let dribbles: ScorerDribbles
    public let fouls: ScorerFouls
    public let cards: ScorerCards
    public let penalty: ScorerPenalty

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case league = "league"
        case games = "games"
        case substitutes = "substitutes"
       // case shots = "shots"
        case goals = "goals"
        case passes = "passes"
        case tackles = "tackles"
        case duels = "duels"
        case dribbles = "dribbles"
        case fouls = "fouls"
        case cards = "cards"
        case penalty = "penalty"
    }
}

public struct ScorerLeague: Codable, Sendable {
    public let id: Int
    public let name, country: String
    public let logo: String
    public let flag: String?
    public let season: Int
}

// MARK: - Cards
public struct ScorerCards: Codable, Sendable {
    public let yellow: Int
    public let yellowred: Int
    public let red: Int

    enum CodingKeys: String, CodingKey {
        case yellow = "yellow"
        case yellowred = "yellowred"
        case red = "red"
    }
}

// MARK: - Dribbles
public struct ScorerDribbles: Codable, Sendable {
    public let attempts: Int?
    public let success: Int?
    public let past: AnyJSON?

    enum CodingKeys: String, CodingKey {
        case attempts = "attempts"
        case success = "success"
        case past = "past"
    }
}

// MARK: - Duels
public struct ScorerDuels: Codable, Sendable {
    public let total: Int?
    public  let won: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case won = "won"
    }
}

// MARK: - Fouls
public struct ScorerFouls: Codable, Sendable {
    public let drawn: Int?
    public let committed: Int?

    enum CodingKeys: String, CodingKey {
        case drawn = "drawn"
        case committed = "committed"
    }
}

// MARK: - Games
public struct ScorerGames: Codable, Sendable {
    public let appearences: Int
    public let lineups: Int
    public let minutes: Int
    public let number: AnyJSON?
    public let position: String?
    public let rating: String?
    public let captain: Bool

    enum CodingKeys: String, CodingKey {
        case appearences = "appearences"
        case lineups = "lineups"
        case minutes = "minutes"
        case number = "number"
        case position = "position"
        case rating = "rating"
        case captain = "captain"
    }
}


// MARK: - Goals
public struct ScorerGoals: Codable, Sendable {
    public let total: Int
    public let conceded: Int?
    public let assists: Int?
    public let saves: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case conceded = "conceded"
        case assists = "assists"
        case saves = "saves"
    }
}


// MARK: - Passes
public struct ScorerPasses: Codable, Sendable {
    public let total: Int?
    public let key: Int?
    public let accuracy: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case key = "key"
        case accuracy = "accuracy"
    }
}

// MARK: - Penalty
public struct ScorerPenalty: Codable, Sendable {
    public let won: Int?
//    let commited: JSONNull?
    public let scored: Int?
    public let missed: Int?
    public let saved: Int?

    enum CodingKeys: String, CodingKey {
        case won = "won"
//        case commited = "commited"
        case scored = "scored"
        case missed = "missed"
        case saved = "saved"
    }
}

// MARK: - Shots
public struct ScorerShots: Codable, Sendable {
    public let total: Int
    public let on: Int

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case on = "on"
    }
}

// MARK: - Substitutes
public struct Substitutes: Codable, Sendable {
    public let substitutesIn: Int
    public let out: Int
    public let bench: Int

    enum CodingKeys: String, CodingKey {
        case substitutesIn = "in"
        case out = "out"
        case bench = "bench"
    }
}

// MARK: - Tackles
public struct Tackles: Codable, Sendable {
    public let total: Int?
    public let blocks: Int?
    public let interceptions: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case blocks = "blocks"
        case interceptions = "interceptions"
    }
}

