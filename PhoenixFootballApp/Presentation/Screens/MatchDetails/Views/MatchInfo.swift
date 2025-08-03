//
//  MatchInfo.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/16/25.
//



import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct MatchInfo: View {
  let fixture: FixtureDataResponse
  @EnvironmentObject private var pilot: UIPilot<AppRoute>
  @EnvironmentObject var themeManager: ThemeManager
  let tabs = ["Overview", "Lineups", "Stats", "H2H", "Table"]
  @Binding var selection: Int

  var body: some View {
    VStack(spacing: 16) {

      HStack {
        AppBackButton {
          pilot.pop()

        }

        VStack {

            Text(fixture.league.name)
            .body2Medium()
            .foregroundStyle(themeManager.currentTheme.text.sd50)

//          Text("Sunday, 3 September 2023 ")
            Text(fixture.fixture.getStartDate(dateFormat: "EEEE, d MMMM yyyy"))
            .captionReguler()
            .foregroundStyle(themeManager.currentTheme.text.sd600)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        AppBackButton {

        }
        .hidden()
      }
      .padding(.horizontal, 16)
      .padding(.top, 16)

      // Team logos and match time
      HStack(alignment: .center, spacing: 10) {
        // Home team
        VStack(spacing: 8) {
          TeamLogoView(team: fixture.teams.home)
                .onTapGesture {
                    pilot.push(.TeamDetails(team: fixture.teams.home, season: fixture.league.season))
                }

        }
        .frame(maxWidth: .infinity, alignment: .center)

        // Match time
        VStack(spacing: 8) {
//            Text("15:00")
            if fixture.fixture.status.short.willStart(){
                Text(fixture.fixture.getStartDate(dateFormat: "HH:mm"))
                    .h3Medium()
                    .foregroundStyle(themeManager.currentTheme.text.sd50)
                MatchInfoCountdownView(targetDate: fixture.fixture.date)
            }else{
                Text("\(fixture.goals.home ?? 0) : \(fixture.goals.away ?? 0)")
                    .h3Medium()
                    .foregroundStyle(themeManager.currentTheme.text.sd50)
                Text(fixture.fixture.status.long.rawValue)
                  .body2Medium()
                  .foregroundStyle(themeManager.currentTheme.text.sd300)
            }
            
        }
          
          .frame(maxWidth: .infinity, alignment: .center)
        // Away team
        VStack(spacing: 8) {

          TeamLogoView(team: fixture.teams.away)
                .onTapGesture {
                    pilot.push(.TeamDetails(team: fixture.teams.away, season: fixture.league.season))
                }

        }
          .frame(maxWidth: .infinity, alignment: .center)
         
      }
      .padding(.bottom, 24)
      .padding(.horizontal, 11)
     

      CustomTabBar(
        tabs: tabs,
        selectedTab: $selection,
        activeColor: Color.white
      )

    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(content: { GradientView() })
    .onAppear {
      //selectedSeason = league.getCurrentSeason()?.seasonName ?? ""
    }
  }
}

struct TeamLogoView: View {
  let team: Away
  @EnvironmentObject var themeManager: ThemeManager
  var body: some View {
    VStack {

      MediaView(model: .image(url: team.logo))
        .frame(width: 56, height: 56, alignment: .center)

      Text(team.name)
        .body2Medium()
        .foregroundStyle(themeManager.currentTheme.text.sd50)

    }
  }
}

struct MatchInfoCountdownView: View {
  let targetDate: Date
  @State private var timeRemaining: String = ""
    @EnvironmentObject var themeManager: ThemeManager
  private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    Text(timeRemaining)
      .body2Medium()
      .foregroundStyle(themeManager.currentTheme.text.sd300)
      .onAppear {
        updateCountdown()
      }
      .onReceive(timer) { _ in
        updateCountdown()
      }
  }

  private func updateCountdown() {
    let now = Date()
    let remaining = Int(targetDate.timeIntervalSince(now))

    if remaining <= 0 {
      timeRemaining = "00:00:00"
      return
    }

    let hours = remaining / 3600
    let minutes = (remaining % 3600) / 60
    let seconds = remaining % 60

    timeRemaining = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
  }
}
