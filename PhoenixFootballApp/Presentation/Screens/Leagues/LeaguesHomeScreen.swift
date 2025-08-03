//
//  LeaguesHomeScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/18/25.
//

import APIFootball
import PhoenixUI
import SwiftUI
import XSwiftUI

struct LeaguesHomeScreen: View {

  @EnvironmentObject var leaguesListViewModel: LeaguesListViewModel
//    = LeaguesListViewModelBindings().getDependency()

  @State var searchLeagueText: String = ""
    @State var isSearchActive: Bool = false

  @State var isLoading = false
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("Leagues")
        .font(.manrope(.semiBold, size: 20))
        .foregroundStyle(.white)

      AppTextField(
        placeholderText: "Find leagues",
        text: $searchLeagueText,
        textColor: Color(hex: "ffffff"),
        backGroundColor: Color(hex: "01080E")

      ) {
        Image(.searchRefraction)
      } suffixView: {

      }
      .onChange(of: searchLeagueText, perform: { key in
          isSearchActive = key.isEmpty ? false : true
          
          leaguesListViewModel.searchLeagues(key: key)
      })

      if isLoading {
        ProgressView()
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      } else {
        FootballLeaguesView(isSearchActive: $isSearchActive)
      }

      Spacer()
    }
    .padding(.horizontal, 16)
    .frame(maxWidth: .infinity, alignment: .topLeading)
    .background(Color(hex: "000306"))
   
    .task {
      if leaguesListViewModel.leagues.isEmpty {
        isLoading = true
        await leaguesListViewModel.getAllLeagues()
        isLoading = false
      }

    }

  }
}

#Preview{
  LeaguesHomeScreen()
}
