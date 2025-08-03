//
//  PLayerInfoView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/13/25.
//



import APIFootball
import Combine
import InfiniteScrollView
import SUIRouter
import SwiftUI
import XSwiftUI

struct PLayerInfoView: View {
  let player: SquadPlayer
  @EnvironmentObject private var pilot: UIPilot<AppRoute>
  @EnvironmentObject var themeManager: ThemeManager
  let tabs = ["Profile",
              //"Stats",
              "Career"]
  @Binding var selection: Int

  var body: some View {
    VStack(spacing: 16) {

      HStack {
        AppBackButton {
          pilot.pop()

        }

        VStack {

        }
        .frame(maxWidth: .infinity, alignment: .center)
        AppBackButton {

        }
        .hidden()
      }
      .padding(.horizontal, 16)
      .padding(.top, 16)

      HPlayerLogo(player: player)
        .padding(.horizontal, 16)
        .padding(.vertical, 16)

      CustomTabBar(
        tabs: tabs,
        selectedTab: $selection,
        activeColor: Color.white
      )

    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(content: { GradientView() })
  }
}

struct HPlayerLogo: View {
  let player: SquadPlayer
  @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var viewModel: PlayerProfileViewModel
  var body: some View {
    HStack {

      MediaView(model: .image(url: player.photo))
        .frame(width: 70, height: 70, alignment: .center)
        .cornerRadius(35)

      VStack(alignment: .leading, spacing: 10) {
        Text(player.name)
          .h6Semibold()
          .foregroundStyle(themeManager.currentTheme.text.sd50)
          
          if let team = viewModel.playerTeam{
              HStack{
                  MediaView(model: .image(url: team.logo))
                      .frame(width: 22, height: 22)
                  
                  Text(team.name)
                      .body1Semebold()
                      .foregroundStyle(themeManager.currentTheme.text.sd50)
                  
              }
          }
         

      }
      .frame(maxWidth: .infinity, alignment: .leading)

    }
  }
}
