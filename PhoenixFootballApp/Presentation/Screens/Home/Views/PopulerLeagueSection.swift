//
//  PopulerLeagueSection.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//


import Combine
import SUIRouter
import SwiftUI
import XSwiftUI



struct PopulerLeagueSection:View {
    @EnvironmentObject var leaguesListViewModel: LeaguesListViewModel
    @EnvironmentObject var homeTab: HomeTabControler
    @EnvironmentObject var settingsViewModel: AppSettingsViewModel
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    
    var body: some View {
        
        VStack(spacing: 20){
            if leaguesListViewModel.getTopLeaguesFromServer(topLeagueIDs: settingsViewModel.topLeaguesID).isEmpty  == false{
                
                HeaderWithViewAll(title: "Popular League") {
                    homeTab.activeOption = .Leagues
                }
                .padding(.horizontal, 16)
                
                
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        
                        ForEach(leaguesListViewModel.getTopLeaguesFromServer(topLeagueIDs: settingsViewModel.topLeaguesID), id: \.league.id) { league in
                            CirculerLeagueImage(league: league.league.logo)
                               .onTapGesture {
                                   pilot.push(.leagueDetails(league: league))
                               }
                          
                        }
                        
                      
                    }
                    .padding(.vertical, 4)
                    .padding(.leading, 16)
                }
            }
            
        }
    }
}

struct CirculerLeagueImage: View {
    let league:String
    var body: some View {
        VStack{
            MediaView(
                model: MediaContentModel(
                    mediaType: .image,
                    imageURL: league,
                    videoData: nil,
                    gifURL: nil
                )
            )
            .scaledToFit()
//            .scaledToFill()
            .frame(width: 60, height: 60)
            .frame(width: 80, height: 80, alignment: .center)
            .cornerRadius(40, corners: .allCorners)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color(hex: "4A7181"), lineWidth: 2)
            )
        }
        .frame(width: 80, height: 80)
    }
}
