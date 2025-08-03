//
//  StandingsRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import EasyXConnect
import Foundation

public protocol IStandingRepository: Actor {

  func getStandingByLeagueAndSeason(league: Int, season: Int) async throws -> [Standing]
  func getStandingByTeamAndSeason(team: Int, season: Int) async throws -> [StandingResponse]
}

actor StandingsRepository: IStandingRepository {

  private let client: ExHttpConnect

  init(client: ExHttpConnect) {
    self.client = client
  }

  func getStandingByLeagueAndSeason(league: Int, season: Int) async throws -> [Standing] {

    var list: [Standing] = []

    do {

      let query: [String: String] = [
        "season": "\(season)",
        "league": "\(league)",
      ]

      let res: AppResponse<GenericNetworkModel<LeagueStandingsResponse>> = try await client.get(
        "standings", headers: [:], query: query)

      if let data = res.payload?.data?.response.first?.league.standings.first {
        list = data
      }

    }

    return list
  }

  func getStandingByTeamAndSeason(team: Int, season: Int) async throws -> [StandingResponse] {
    var list: [StandingResponse] = []

    do {

      let query: [String: String] = [
        "season": "\(season)",
        "team": "\(team)",
      ]

      let res: AppResponse<GenericNetworkModel<LeagueStandingsResponse>> = try await client.get(
        "standings", headers: [:], query: query)

      if let data = res.payload?.data?.response {
        list = data
      }

    }

    return list
  }

}
