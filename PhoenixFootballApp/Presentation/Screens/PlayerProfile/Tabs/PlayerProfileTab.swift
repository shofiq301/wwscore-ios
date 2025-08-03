//
//  PlayerProfileTab.swift
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
struct PlayerProfileTab: View {
    let player: SquadPlayer
    @EnvironmentObject var viewModel: PlayerProfileViewModel
    
  var body: some View {
      VStack(spacing: 10) {

        HStack(alignment: .center, spacing: 12 ) {
            
            if let height = viewModel.player?.height{
                PlayerInfoCard(
                  title: height,
                  text: "Height"
                )
            }
         
         
            if let weight = viewModel.player?.weight{
                PlayerInfoCard(
                  title: weight,
                  text: "Weight"
                )
            }
          
          
          
            if let age = viewModel.player?.age{
                PlayerInfoCard(
                  title: "\(age) Years",
                  text: "Age"
                )
            }
          
         
      }
        HStack(alignment: .center, spacing: 12 ) {
            if let shirt = player.number{
                PlayerInfoCard(
                    title: shirt.description,
                  text: "Shirt"
                )
            }
         
         
            PlayerInfoCard(
                title: player.position.rawValue,
              text: "position"
            )
        
          
          
            if let team = viewModel.playerTeam?.name{
                PlayerInfoCard(
                  title: team,
                  text: "Team"
                )
            }
         
          
         
      }
           
          if let nationality = viewModel.player?.nationality{
              PlayerNationalityCard( text: nationality )
          }
         
          
          
          Spacer()
    }
    .padding(.horizontal, 14)
  }
}

struct PlayerInfoCard: View {
  @EnvironmentObject var themeManager: ThemeManager
  let title: String
  let text: String
    init(title: String, text: String) {
       
        self.title = title
        self.text = text
    }
  var body: some View {
      VStack(spacing: 12) {
        Text(title)
            .h6Semibold()
            .foregroundStyle(.white)
        
        Text(text)
            .body2Regular()
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .foregroundStyle(themeManager.currentTheme.text.sd600)
        
    }
      .frame(height: 80.width(), alignment: .center)
      .frame(maxWidth: .infinity)
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



struct PlayerNationalityCard: View {
  @EnvironmentObject var themeManager: ThemeManager
  
  let text: String
    init( text: String) {
       
      
        self.text = text
    }
  var body: some View {
      VStack(alignment: .leading,spacing: 16) {
        Text("Nationality")
            .body1Semebold()
            .foregroundStyle(.white)
            .padding(.horizontal, 14)
          
          Divider()
              .frame(height: 1)
              .foregroundStyle(themeManager.currentTheme.backgroundDefault)
          
          HStack{
              if let countryFLag = CountryFlagMap.initialFlagMap[text]{
                  MediaView(model: .image(url: countryFLag))
                      .frame(width: 32, height: 32)
                      .cornerRadius(16, corners: .allCorners)
              }
            
              Text(text)
                .h6Semibold()
                .foregroundStyle(themeManager.currentTheme.text.sd600)
                .padding(.horizontal, 14)
          }
    }
//      .frame(height: 115.width(), alignment: .leading)
      .frame(maxWidth: .infinity,alignment: .leading)
      .padding(.horizontal, 14)
      .padding(.vertical, 16)
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

