//
//  ContentView.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 9/2/25.
//

import SwiftUI
import PhoenixUI
import XSwiftUI
import SUIRouter
import APIFootball
import SwifterSwift

struct ContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    var body: some View {
        ZStack {
            RouteSetupView(pilot: isOnboarding ? UIPilot(AppRoute.onboarding) : UIPilot(AppRoute.Home)) { pilot in
            UIPilotHost(pilot) { route in
              switch route {
              case .Home:
                  HomeScreen()
              case .onboarding:
                  OnboardingView(onboarding: $isOnboarding)
              case .leagueDetails(let data):
                  LeagueDetailsScreen(league: data)
              case .MatchDetaild(match: let match):
                  MatchDetailsScreen(fixture: match)
              case .TeamDetails(let team, let season):
                  TeamDetailsScreen(team: team,season : season)
              case .NewsDetails(news: let news):
                  NewsDetailsScreen(news: news)
              case .PlayerProfile(player: let player, season: let season):
                  PlayerProfileScreen(player: player, season: season)
              case .LiveMatchPage:
                  LiveMatchPage()
              case .playerPage(urls: let urls):
                  VideoPlayerPage(urls: urls)
              }
            }
          }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    ContentView()
}
