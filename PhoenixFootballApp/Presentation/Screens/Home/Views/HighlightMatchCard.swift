//
//  HighlightMatchCard.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct HighlightMatchCard: View {
  let match: FixtureDataResponse
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    
    @EnvironmentObject var themeManager: ThemeManager
  var body: some View {
      Button(action:{
          pilot.push(.MatchDetaild(match: match))
      }){
        ZStack {
          // Background
          RoundedRectangle(cornerRadius: 12)
                .fill(themeManager.currentTheme.primary.sd700)
            .frame(height: 183)

          VStack(spacing: 20) {
            // Header with Premier League logo and Highlight badge
            HStack {
              HStack(spacing: 8) {
                // Premier League logo (simplified as a circle with color)
                MediaView(
                  model: MediaContentModel(
                    mediaType: .image, imageURL: match.league.logo, videoData: nil, gifURL: nil)
                )
                .frame(width: 20, height: 20)

                Text(match.league.name)
                      .body2Medium()
                  .foregroundColor(themeManager.currentTheme.text.sd50)
                  .font(.system(size: 16, weight: .medium))
              }

              Spacer()
            }
            .padding(.horizontal, 14)

            // Match details
            HStack(alignment: .bottom) {
              // Left team
              VStack(spacing: 12) {
                // Chelsea logo (simplified)
                MediaView(
                  model: MediaContentModel(
                    mediaType: .image, imageURL: match.teams.home.logo, videoData: nil, gifURL: nil)
                )
                .frame(width: 46, height: 46)

                Text(match.teams.home.name)
                      .body2Medium()
                  .foregroundColor(themeManager.currentTheme.text.sd50)
                  .multilineTextAlignment(.center)
              }
              .frame(maxWidth: .infinity, alignment: .leading)

              Spacer()

              // Match time details
                if match.fixture.status.short.willStart(){
                    VStack(spacing: 24) {
                      // Timer
//                      Text("05:11:67")
                        Text(match.fixture.getStartDate(dateFormat: "HH:mm:ss"))
                        .font(.manrope(.medium, size: 18))
                        .foregroundColor(themeManager.currentTheme.text.sd50)

                      // Match time
//                      Text("1:00 pm")
                        Text(match.fixture.getStartDate(dateFormat: "h:mm a"))
                            .body2Medium()
                            .foregroundColor(themeManager.currentTheme.text.sd300)
                    }
                }else{
                    VStack{
                        Spacer()
                        Text("\(match.goals.home ?? 0):\(match.goals.away ?? 0)")
                          .font(.manrope(.bold, size: 24))
                          .foregroundColor(themeManager.currentTheme.text.sd50)
                        
                        Spacer()
                    }
                }
              

              Spacer()

              // Right team
              VStack(spacing: 12) {
                // Crystal Palace logo (simplified)
                MediaView(
                  model: MediaContentModel(
                    mediaType: .image, imageURL: match.teams.away.logo, videoData: nil, gifURL: nil)
                )
                .frame(width: 46, height: 46)

                Text(match.teams.away.name)
                      .body2Medium()
                  .foregroundColor(themeManager.currentTheme.text.sd50)
                  .multilineTextAlignment(.center)
              }
              .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 14)

            // Pagination indicators

          }
          .padding(.vertical, 29)
          //            .padding(.horizontal, 14)
        }
        .padding(.horizontal, 16)
    }
      .buttonStyle(.plain)
  }
}

// For preview
// For a full carousel implementation
struct MatchCarousel: View {
  @State private var currentPage = 0
  @EnvironmentObject var homeViewModel: HomeViewModel

  var body: some View {
    VStack(spacing: 0) {

      if homeViewModel.highlightedFixtureList.isEmpty == false {
        Text("Highlight Match")
          .font(.manrope(.semiBold, size: 20))
          .foregroundStyle(.white)
          .padding(.bottom, 20)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 16)

        TabView(selection: $currentPage) {
          ForEach(homeViewModel.highlightedFixtureList.indices, id: \.self) { idx in
            HighlightMatchCard(match: homeViewModel.highlightedFixtureList[idx])
              .tag(idx)
          }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 200)

        HStack(spacing: 6) {
          ForEach(homeViewModel.highlightedFixtureList.indices, id: \.self) { i in
            Capsule()
              .fill(i == currentPage ? Color(hex: "1976D2") : Color.white)
              .frame(width: i == currentPage ? 18 : 6, height: 6)
          }
        }
        .padding(.top, 4)
      }

    }
  }
}
