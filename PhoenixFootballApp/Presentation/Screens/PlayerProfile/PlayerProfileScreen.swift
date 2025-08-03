//
//  PlayerProfileScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/30/25.
//

import APIFootball
import Combine
import InfiniteScrollView
import SUIRouter
import SwiftUI
import XSwiftUI
import WrappingHStack

struct PlayerProfileScreen: View {
  let player: SquadPlayer
  let season: Int
  @State var selection: Int = 0
  @EnvironmentObject private var pilot: UIPilot<AppRoute>
  @EnvironmentObject var themeManager: ThemeManager

  @StateObject var viewModel: PlayerProfileViewModel = PlayerProfileViewModelBindings()
    .getDependency()

  var body: some View {
    VStack(alignment: .leading) {
      PLayerInfoView(player: player, selection: $selection)
            .padding(.bottom, 10)
        TabView(selection: $selection) {
            PlayerProfileTab(player: player)
                .tag(0)
            
//            VStack{}
//                .tag(1)
            
            VStack{
                PlayerCareerTab()
            }
                .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
     
        Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(themeManager.currentTheme.backgroundDefault)
    .environmentObject(viewModel)
    .task {
        await viewModel.getPlayerSeasons(playerID: player.id)
        Task{
            await viewModel.getPlayerSquards(playerID: player.id)
        }
        Task{
            await viewModel.getPlayersTrophies(playerID: player.id)
        }
        if let latestSeason = viewModel.getLatestSeason(){
            await viewModel.getPlayerData(playerID: player.id, season: latestSeason)
        }else{
            await viewModel.getPlayerData(playerID: player.id, season: season)
        }
      
    }
  }
}


struct PlayerCareerTab:View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var viewModel: PlayerProfileViewModel
    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .leading){
                    
                    Text("Honours")
                        .h4Semibold()
                        .foregroundStyle(themeManager.currentTheme.text.sd50)
                        .padding(.bottom, 32)
                    
                    
                   ForEach(viewModel.trophiesBySeason, id: \.key) { tr in
                       VStack(alignment: .leading, spacing: 14){
                            Text(tr.key)
//                            Text(tr.value)
                               .foregroundStyle(.white)
                           
                           
                           Divider()
                               .foregroundStyle(themeManager.currentTheme.background.sd400)
                           
//                            HStack{
//                                
//                                ForEach(tr.value){ v in
//                                    
//                                    TrophiesNameCard(name: v.league)
//                                }
//                            }
                           
                           WrappingHStack(tr.value, id:\.self) {
                               TrophiesNameCard(name: $0.league)
                           }
                           
                        }
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.bottom, 10)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 14)
        }
    }
}


struct TrophiesNameCard:View {
    @EnvironmentObject var themeManager: ThemeManager
    let name:String
    var body: some View {
        VStack{
            Image(.laliga)
                .frame(width: 60, height: 60)
            
            Text(name)
                .body2Regular()
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(themeManager.currentTheme.text.sd200)
            
        }
        .frame(width: 80.width(), height: 108.width())
        .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                          Color(hex: "000306").opacity(0.3),
                          Color(hex: "00366C").opacity(0.2)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        .border(width: 1, color: themeManager.currentTheme.primary.sd900, cornerRadius: 10)
    }
}
