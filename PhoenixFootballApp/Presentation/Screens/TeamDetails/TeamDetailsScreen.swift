//
//  TeamDetailsScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/30/25.
//

import APIFootball
import Combine
import InfiniteScrollView
import SUIRouter
import SwiftUI
import XSwiftUI

struct TeamDetailsScreen: View {
  let team: Away
  let season: Int
  @EnvironmentObject private var pilot: UIPilot<AppRoute>
  @EnvironmentObject var themeManager: ThemeManager
  //    let tabs = ["Overview", "News", "Matches",  "Table", "Squad"]
  @State var selection: Int = 0

  @StateObject var teamViewModel: TeamDetailsViewModel
  @StateObject var teamSquadViewModel: TeamSquadViewModel
  @StateObject var newsViewModel: NewsViewModel
  @StateObject var teamMatchListViewModel: TeamMatchListViewModel = TeamMatchListViewModelBindings()
    .getDependency()

  init(team: Away, season: Int) {
    self.team = team
    self.season = season
    _teamViewModel = StateObject(
      wrappedValue: TeamDetailsViewModelBindings(teamID: team.id).getDependency())
    _teamSquadViewModel = StateObject(
      wrappedValue: TeamSquadViewModelBindings(teamID: team.id).getDependency())
    _newsViewModel = StateObject(wrappedValue: NewsViewModelBindings().getDependencyForHome())
  }

  var body: some View {
    VStack(alignment: .leading) {

      TeamInfoView(team: team, selection: $selection)

      TabView(selection: $selection) {

        VStack {
          //            Last5FixtureListCardView(ownTeamID: team.id)
          TeamOverViewTab(ownTeamID: team.id)

        }
        .tag(0)

        VStack {
          InfiniteList(
            data: $newsViewModel.trendingNewsList,
            loadingView: {
              ProgressView()
                .foregroundColor(.white)
            },
            scrollEnable: true,
            loadMore: {
              await newsViewModel.loadMoreTrendingNews(leagueId: nil)
              // loadMore()
              print("load more")
            }
          ) { item in
            NewsHorizontalCardSmallView(news: item)
          }
        }
        .padding(.horizontal, 16)
        .tag(1)

        VStack {
          TeamMatchList()
            .padding(.top, 20)
        }
        .tag(2)

        VStack {
            TeamStandingsTabView(standings: teamViewModel.standingsList)
        }
        .tag(3)

        TeamSquadTab(season: season)
          .tag(4)
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

    }
    .frame(maxWidth: .infinity)
    .background(themeManager.currentTheme.backgroundDefault)
    .environmentObject(teamViewModel)
    .environmentObject(teamSquadViewModel)
    .environmentObject(teamMatchListViewModel)
    .task {
      await teamViewModel.getTeamInfo(id: team.id)
      await teamSquadViewModel.getTeamSquad(teamId: team.id)
      Task {
        await teamViewModel.getSTandings(team: team.id, currentSeason: season)
      }
      Task {
        await teamViewModel.getFixtureByTeam(team: team.id, currentSeason: season)
      }
      Task {
        await teamMatchListViewModel.getMatchesByTeam(teamID: team.id, season: season)
      }

      Task {
        await teamMatchListViewModel.getLast5Fixture(teamID: team.id)
      }

      Task {
        await teamMatchListViewModel.getnextFixture(teamID: team.id)
      }
    }

  }
}

struct TeamMatchList: View {

  @EnvironmentObject var teamMatchListViewModel: TeamMatchListViewModel

  var body: some View {
    VStack {
      ScrollView {
        LazyVStack(spacing: 20) {
          ForEach(Array(teamMatchListViewModel.fixtureListByLeague.enumerated()), id: \.1.0) {
            index, item in
            let (leagueName, fixtures) = item
            MatchesByLeagueView2(date: leagueName, fixtures: fixtures, isExpanded: true)
          }
        }
      }
    }
  }
}
