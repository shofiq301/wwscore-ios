//
//  PlayersStatisticsResponse.swift
//  APIFootball
//
//  Created by Shahanul Haque on 7/7/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playersStatisticsResponse = try? JSONDecoder().decode(PlayersStatisticsResponse.self, from: jsonData)

//
//  PlayersStatisticsResponse.swift
//  APIFootball
//
//  Created by Shahanul Haque on 7/7/25.
//

import Foundation

// MARK: - PlayersStatisticsResponse
public struct PlayersStatisticsResponse: Codable, Sendable {
    public let status: Bool
    public let message: String
    public let data: PlayersStatisticsDataClass

    public init(status: Bool, message: String, data: PlayersStatisticsDataClass) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - PlayersStatisticsDataClass
public struct PlayersStatisticsDataClass: Codable, Sendable {
    public let results: Int
    public let paging: Paging
    public let response: [PlayersStatisticsResponseModel]

    public init(results: Int, paging: Paging, response: [PlayersStatisticsResponseModel]) {
        self.results = results
        self.paging = paging
        self.response = response
    }
}

// MARK: - PlayersStatisticsResponseModel
public struct PlayersStatisticsResponseModel: Codable, Sendable {
    public let player: PlayerModel
    public let statistics: [PlayerStatistic]

    public init(player: PlayerModel, statistics: [PlayerStatistic]) {
        self.player = player
        self.statistics = statistics
    }
}

// MARK: - PlayerStatistic
public struct PlayerStatistic: Codable, Sendable {
    public let team: Team
    public let league: PlayerStatisticLeague
    public let games: Games
    public let substitutes: Substitutes
    public let shots: Shots
    public let goals: Goals
    public let passes: Passes
    public let tackles: Tackles
    public let duels: Duels
    public let dribbles: Dribbles
    public let fouls: Fouls
    public let cards: Cards
    public let penalty: Penalty

    public init(team: Team, league: PlayerStatisticLeague, games: Games, substitutes: Substitutes, shots: Shots, goals: Goals, passes: Passes, tackles: Tackles, duels: Duels, dribbles: Dribbles, fouls: Fouls, cards: Cards, penalty: Penalty) {
        self.team = team
        self.league = league
        self.games = games
        self.substitutes = substitutes
        self.shots = shots
        self.goals = goals
        self.passes = passes
        self.tackles = tackles
        self.duels = duels
        self.dribbles = dribbles
        self.fouls = fouls
        self.cards = cards
        self.penalty = penalty
    }
}
public struct PlayerStatisticLeague: Codable, Sendable {
    public let id: Int?
    public let name, country: String?
    public let logo: String?
    public let flag: String?
    public let season: Int?
    public let round: String?
}
// MARK: - Cards
public struct Cards: Codable, Sendable {
    public let yellow, yellowred, red: Int

    public init(yellow: Int, yellowred: Int, red: Int) {
        self.yellow = yellow
        self.yellowred = yellowred
        self.red = red
    }
}

// MARK: - Dribbles
public struct Dribbles: Codable, Sendable {
    public let attempts, success: Int?
    public let past: String?

    public init(attempts: Int?, success: Int?, past: String?) {
        self.attempts = attempts
        self.success = success
        self.past = past
    }
}

// MARK: - Duels
public struct Duels: Codable, Sendable {
    public let total, won: Int?

    public init(total: Int?, won: Int?) {
        self.total = total
        self.won = won
    }
}

// MARK: - Fouls
public struct Fouls: Codable, Sendable {
    public let drawn, committed: Int?

    public init(drawn: Int?, committed: Int?) {
        self.drawn = drawn
        self.committed = committed
    }
}

// MARK: - Games
public struct Games: Codable, Sendable {
    public let appearences, lineups, minutes: Int?
    public let number: String?
    public let position: String?
    public let rating: String?
    public let captain: Bool?

    public init(appearences: Int?, lineups: Int?, minutes: Int?, number: String?, position: String?, rating: String?, captain: Bool?) {
        self.appearences = appearences
        self.lineups = lineups
        self.minutes = minutes
        self.number = number
        self.position = position
        self.rating = rating
        self.captain = captain
    }
}



// MARK: - League

// MARK: - Passes
public struct Passes: Codable, Sendable {
    public let total, key, accuracy: Int?

    public init(total: Int?, key: Int?, accuracy: Int?) {
        self.total = total
        self.key = key
        self.accuracy = accuracy
    }
}

// MARK: - Penalty
public struct Penalty: Codable, Sendable {
    public let won, commited: String?
    public let scored, missed: Int?
    public let saved: String?

    public init(won: String?, commited: String?, scored: Int?, missed: Int?, saved: String?) {
        self.won = won
        self.commited = commited
        self.scored = scored
        self.missed = missed
        self.saved = saved
    }
}

// MARK: - Shots
public struct Shots: Codable, Sendable {
    public let total, on: Int?

    public init(total: Int?, on: Int?) {
        self.total = total
        self.on = on
    }
}

