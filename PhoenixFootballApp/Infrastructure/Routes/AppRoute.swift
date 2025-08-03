//
//  AppRoute.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/6/25.
//

import Foundation
import SwiftUI
import APIFootball
// Define routes of the app
public enum AppRoute: Equatable {
  // As swift not able to identify type of closure by default
  public static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
    return lhs.key == rhs.key
  }

  case Home
  case onboarding
    case leagueDetails(league:LeagueData)
    case MatchDetaild(match: FixtureDataResponse)
    case TeamDetails(team: Away, season: Int)
    case NewsDetails(news: NewsDoc)
    case PlayerProfile(player:SquadPlayer, season:Int)
    case LiveMatchPage
    case playerPage(urls:[URLElement])

  var key: String {
    switch self {
    case .Home:
        return "HomeScreen"
    case .onboarding:
        return "OnboardingView"
    case .leagueDetails(let data):
        return "LeagueDetailsView/\(data.league.id)"
    case .MatchDetaild(let data):
        return "MatchDetailsView/\(data.id)"
    case .TeamDetails( let team, let season):
        return "TeamDetailsView/\(team.id)_\(season)"
    case .NewsDetails(news: let news):
        return "NewsDetailsView/\(news.id ?? "")"
    case .PlayerProfile(player: let player,  _):
        return "PlayerProfileView/\(player.name )"
    case .LiveMatchPage:
        return "LiveMatchPage"
    case .playerPage:
        return "PlayerPage"
    }
  }
}
//extension View {
//    func tag() -> String {
//        return String(describing: type(of: self))
//    }
//}

extension AppRoute: CustomStringConvertible {
  public var description: String {
    return key
  }
}
