//
//  HeadToHeadMatchList.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/24/25.
//


import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct HeadToHeadMatchList: View {
    let h2hList: [FixtureDataResponse]
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        LazyVStack{
         
            ForEach(h2hList) { list in
                VStack{
                    HStack{
                        Text("Mon, Oct 24,2023")
                            .captionMedium()
                            .foregroundStyle(themeManager.currentTheme.text.sd500)
                        
                        Spacer()
                        Text(list.league.name.uppercased())
                            .captionMedium()
                            .foregroundStyle(themeManager.currentTheme.text.sd500)
                        
                    }
                    H2HMatchRow(match: list)
                    
                    if list != h2hList.last{
                        Divider()
                            .padding(.bottom, 14)
                    }
                }
            }
            
        }
        .padding(.all, 20)
        .background(themeManager.currentTheme.background.sd500)
        .border(width: 1, color: themeManager.currentTheme.background.sd400, cornerRadius: 16)
    }
}
struct H2HMatchRow: View {
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
        .padding(.vertical, 16)
    }
      .buttonStyle(.plain)
  }
}
