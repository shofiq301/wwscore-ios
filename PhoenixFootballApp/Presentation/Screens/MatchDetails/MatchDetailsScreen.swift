//
//  MatchDetailsScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/15/25.
//

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct MatchDetailsScreen: View {
  let fixture: FixtureDataResponse
  @EnvironmentObject private var pilot: UIPilot<AppRoute>
  @EnvironmentObject var themeManager: ThemeManager

  @StateObject var viewModel: MatchDetailsViewModel
  @StateObject private var eventViewModel: KeyEventsViewModel
  @StateObject var lineUpViewMOdel: LineUpViewModel
    @StateObject var statisticsViewModel : StatisticsViewModel
    @StateObject var h2Toh2ViewModel : HeadToHeadViewModel
  init(fixture: FixtureDataResponse) {
    self.fixture = fixture

    _viewModel = StateObject(
      wrappedValue: MatchDetailsViewModelBindings(matchId: fixture.fixture.id).getDependency())

    self._eventViewModel = StateObject(
      wrappedValue: KeyEventsViewModelBindings(fixture: fixture.fixture.id).getDependency())

    _lineUpViewMOdel = StateObject(
      wrappedValue: LineUpViewModelBindings(fixtureId: fixture.fixture.id).getDependency())
      
      self._statisticsViewModel = StateObject(wrappedValue: StatisticsViewModelbindings(fixture: fixture.fixture.id).getDependices())
      _h2Toh2ViewModel = StateObject(wrappedValue: HeadToHeadViewModelBindings(homeTeam: fixture.teams.home.id, awayTeam: fixture.teams.away.id).getDependency())
  }

  @State var selectedTab: Int = 0
  var body: some View {
    VStack {
      MatchInfo(fixture: fixture, selection: $selectedTab)
        .padding(.bottom, 10)

      TabView(selection: $selectedTab) {
        VStack {
          if fixture.fixture.status.short.willStart() {
            MatchOverView(fixture: fixture)
          } else if eventViewModel.loading {
            ProgressView()
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
          } else if eventViewModel.eventList.isEmpty {
            MatchOverView(fixture: fixture)
          } else {
            MatchTimelineView(fixture: fixture.fixture.id, homeTeamId: fixture.teams.home.id)
          }

          Spacer()
        }
        .tag(0)

        VStack {
          if let home = lineUpViewMOdel.getLineUpBuTeam(teamId: fixture.teams.home.id),
            let away = lineUpViewMOdel.getLineUpBuTeam(teamId: fixture.teams.away.id)
          {
            ScrollView {
              TeamFormationCard(homeTeam: home, awayTeam: away)
                .padding(.bottom, 50)
            }
          }else{
            VStack {
                Spacer()
              Text("Lineup not available.")
                .body1Semebold()
                .foregroundColor(themeManager.currentTheme.textDefault)
                .padding()
              Spacer()
            }
          }

        }
        .tag(1)
          StatisticsTabView(model: fixture)
        .tag(2)
        VStack {
            
            ScrollView{
                LazyVStack{
                    FixtureHeadToHeadCard(h2hList: h2Toh2ViewModel.h2hList, match: fixture)
                    HeadToHeadMatchList(h2hList: h2Toh2ViewModel.h2hList)
                        .padding(.bottom, 100)
                }
            }
        }
        .tag(3)

        VStack {
          LeagueStandingsView(standings: viewModel.standingsList, withTaggleButton: false)
        }
        .tag(4)
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    .frame(maxWidth: .infinity)
    .background(themeManager.currentTheme.backgroundDefault)
    .environmentObject(viewModel)
    .environmentObject(eventViewModel)
    .environmentObject(lineUpViewMOdel)
    .environmentObject(statisticsViewModel)
    .environmentObject(h2Toh2ViewModel)
    .task {
      await viewModel.getSTandings(
        leagueId: fixture.league.id, currentSeason: fixture.league.season)
    }
  }
}

