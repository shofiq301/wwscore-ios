//
//  MatchesByLeagueView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//

import Combine
import SUIRouter
import SwiftUI
import XSwiftUI
import APIFootball

struct MatchesByLeagueView: View {
    
   let leagueName: String
    let fixtures: [FixtureDataResponse]
  

  @State var isExpanded = false

  var body: some View {
    ZStack {
      // Background
      RoundedRectangle(cornerRadius: 16)
        .fill(Color(hex: "01080E"))
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .strokeBorder(Color(hex: "34393E"), lineWidth: 0.5)
        )

      VStack(spacing: 0) {
        // Header
        Button(action: {
          withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            isExpanded.toggle()
          }
        }) {
          HStack {
            // League logo and name
            HStack(spacing: 10) {
              MediaView(
                model: MediaContentModel(
                  mediaType: .image,
                  imageURL: fixtures.first?.league.logo ?? "", videoData: nil,
                  gifURL: nil)
              )
              .frame(width: 20, height: 20)

              Text(leagueName)
                .font(.manrope(.medium, size: 14))
                .foregroundStyle(Color(hex: "F7F7F8"))
                .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

//            Spacer()

            Image(systemName: "chevron.up")
              .foregroundColor(.white.opacity(0.6))
              .font(.system(size: 14))
              .rotationEffect(.degrees(isExpanded ? 0 : 180))
              .animation(.spring(), value: isExpanded)
          }
          .background(Color(hex: "01080E"))
          .padding(.horizontal, 16)
          .padding(.vertical, 14)
        }
        .buttonStyle(PlainButtonStyle())

        if isExpanded {
          Divider()
            .background(Color.white.opacity(0.1))
            .padding(.bottom, 7)

          // Match list
          VStack(spacing: 0) {
            ForEach(fixtures) { match in
              MatchRow(match: match)
            }
          }
          .padding(.horizontal, 16)
          .padding(.bottom, 14)

        }
      }
    }
    //    .frame( height: isExpanded ? 220 : 60)
    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isExpanded)
  }
}

struct MatchRow: View {
  let match: FixtureDataResponse
    
    init(match: FixtureDataResponse) {
        self.match = match
      
    }
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
  var body: some View {
      Button(action:{
          pilot.push(.MatchDetaild(match: match))
      }){
        HStack {
          // Home team
          HStack(spacing: 4) {
              Text(match.teams.home.name)
              .font(.manrope(.medium, size: 14))
              .foregroundStyle(Color(hex: "F7F7F8"))

            MediaView(
              model: MediaContentModel(
                mediaType: .image, imageURL: match.teams.home.logo,
                videoData: nil, gifURL: nil)
            )
            .frame(width: 20, height: 20)
          }
          .frame(maxWidth: .infinity, alignment: .trailing)

          
          // Match time
          VStack(alignment: .center) {
    //          Text(match.fixture.status.short.rawValue)
    //              .foregroundStyle(Color(hex: "B3B1BA"))
              if  match.fixture.status.short.willStart(){
                  Text(match.fixture.date.string(withFormat: "h:mm a"))
                  .font(.manrope(.medium, size: 12))
                  .foregroundStyle(Color(hex: "B3B1BA"))
              }else{
                  Text("\(match.goals.home ?? 0) : \(match.goals.away ?? 0)")
                  .font(.manrope(.medium, size: 12))
                  .foregroundStyle(Color(hex: "B3B1BA"))
              }
              
          }
          .frame(width: 60, alignment: .center)

          // Away team
          HStack(spacing: 4) {
            // Crystal Palace logo placeholder
            MediaView(
              model: MediaContentModel(
                mediaType: .image, imageURL: match.teams.away.logo,
                videoData: nil, gifURL: nil)
            )
            .frame(width: 20, height: 20)

              Text(match.teams.away.name)
              .font(.manrope(.medium, size: 14))
              .foregroundStyle(Color(hex: "F7F7F8"))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(alignment: .center)
        .padding(.vertical, 18)
    }
      .buttonStyle(.plain)
  }
}
