//
//  HomeMatchListSection.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct HomeMatchListSection: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  @EnvironmentObject var homeTab: HomeTabControler
  var body: some View {
    VStack(spacing: 20) {

      if homeViewModel.fixtureListByLeague.isEmpty == false {
        HeaderWithViewAll(title: "Match List") {
          homeTab.activeOption = .Matches
        }
        .padding(.horizontal, 16)

        ForEach(Array(homeViewModel.fixtureListByLeague.enumerated()).prefix(3), id: \.1.0) {
          index, item in
          let (leagueName, fixtures) = item
          MatchesByLeagueView(leagueName: leagueName, fixtures: fixtures, isExpanded: index < 1)
        }
      }

    }

  }
}
