//
//  TeamInfoView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/27/25.
//



import SwiftUI



import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI


struct TeamInfoView: View {
    let team: Away
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    @EnvironmentObject var themeManager: ThemeManager
    let tabs = ["Overview", "News", "Matches",  "Table", "Squad"]
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

            
            HTeamLogo(team: team)
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

struct HTeamLogo: View {
  let team: Away
  @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var teamViewModel:TeamDetailsViewModel
  var body: some View {
    HStack {

      MediaView(model: .image(url: team.logo))
        .frame(width: 70, height: 70, alignment: .center)

        VStack(alignment: .leading){
          Text(team.name)
            .h6Semibold()
            .foregroundStyle(themeManager.currentTheme.text.sd50)
          
            if let country = teamViewModel.teamInfo?.country{
                Text(country)
                .body2Medium()
                .foregroundStyle(themeManager.currentTheme.text.sd400)
            }
            
      }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
  }
}
