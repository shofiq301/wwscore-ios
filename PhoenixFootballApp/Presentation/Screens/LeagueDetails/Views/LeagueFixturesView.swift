//
//  LeagueFixturesView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/8/25.
//

import SwiftUI
import APIFootball
import XSwiftUI
import EasyXConnect
import EasyX
import SwifterSwift
import SDWebImageSwiftUI
import SDWebImage
import SUIRouter
import PhoenixUI


struct LeagueFixturesView:View {
    @EnvironmentObject var viewModel: LeagueDetailsViewModel
    var body: some View {
        VStack{
            
            if viewModel.matchLoading{
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
             
                  
            }else{
                ScrollView{
                    LazyVStack(spacing: 20)  {
                        ForEach(Array(viewModel.matchListWithChunked.enumerated()), id: \.1.0) { index, item in
                          let (leagueName, fixtures) = item
                            MatchesByLeagueView2(date: leagueName, fixtures: fixtures, isExpanded: true)
                        }
                    }
                }
            }
        }
    }
}

struct MatchesByLeagueView2: View {
    
   let date: String
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
             
              Text(date)
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
