//
//  TeamSquadTab.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/27/25.
//

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct TeamSquadTab: View {
    let season:Int
  @EnvironmentObject var teamSquadViewModel: TeamSquadViewModel
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(teamSquadViewModel.teamSquadBy.sorted(by: { $0.key < $1.key }), id: \.key) { k, v in
          VStack {
            PlayerGroupCard(players: v, position: k, season: season)
          }
        }
      }
    }
  }
}

struct PlayerGroupCard: View {
  let players: [SquadPlayer]
  let position: String
    let season:Int
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
  var body: some View {
      VStack(alignment: .leading, spacing: 16) {

      Text(position)
            .body1Bold()
            .foregroundStyle(themeManager.currentTheme.text.sd50)
        
        Divider()
            .foregroundStyle(themeManager.currentTheme.background.sd400)
//            .padding(.vertical, 14)
        
        
      ForEach(players) { p in

        HStack(spacing: 16){
            MediaView(model: .image(url: p.photo))
                .frame(width: 36, height: 36)
                .cornerRadius(18, corners: .allCorners)
            
            VStack(alignment: .leading) {
                Text(p.name)
                    .body1Semebold()
                    .foregroundStyle(themeManager.currentTheme.text.sd50)
                if let age = p.age{
                    Text("Age: \(age)")
                        .body2Regular()
                        .foregroundStyle(themeManager.currentTheme.text.sd400)
                }
             
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .onTapGesture {
            pilot.push(.PlayerProfile(player: p, season:season))
        }
      }
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 20)
    .background(themeManager.currentTheme.background.sd500)
    .border(width: 1, color: themeManager.currentTheme.background.sd400, cornerRadius: 16)
    
  }
}
