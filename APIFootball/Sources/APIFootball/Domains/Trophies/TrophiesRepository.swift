//
//  TrophiesRepository.swift
//  APIFootball
//
//  Created by Shahanul Haque on 7/13/25.
//

import EasyXConnect
import Foundation

public protocol ITrophiesRepository: Actor {
  func getTrophiesByPlayerID(playerID: Int) async throws -> [TrophiesData]
}

actor TrophiesRepository: ITrophiesRepository {

  let client: ExHttpConnect

  init(client: ExHttpConnect) {
    self.client = client
  }

  func getTrophiesByPlayerID(playerID: Int) async throws -> [TrophiesData] {

    do {
      var list: [TrophiesData] = []

      let query = ["player": "\(playerID)"]

      let res: AppResponse<TrophiesDataClass> = try await client.get(
        "trophies", headers: [:], query: query)

      if let l = res.payload?.response {
        list = l
      }
      return list
    }
  }

}
