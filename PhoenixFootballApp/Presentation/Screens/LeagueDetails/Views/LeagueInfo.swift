//
//  LeagueInfo.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/2/25.
//

import APIFootball
import EasyX
import EasyXConnect
import PhoenixUI
import SDWebImage
import SDWebImageSwiftUI
import SUIRouter
import SwiftUI
import SwifterSwift
import XSwiftUI

struct LeagueInfo:View {
    let league:LeagueData
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    
    let tabs = ["FIXTURES", "TABLE", "NEWS",
    //            "SEASON"
    ]
    @Binding var selection:Int
    
    @EnvironmentObject var viewModel: LeagueDetailsViewModel
    
    
    let onSeasonTap:()->Void
    
    var body: some View {
        VStack(spacing: 16){
         
            HStack{
                AppBackButton(){
                    pilot.pop()
                    
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            HStack(spacing: 10){
                MediaView(model: .image(url: league.league.logo))
                    .frame(width: 70, height: 70, alignment: .center)
             
                VStack(alignment: .leading){
                    Text(league.league.name)
                        .font(.manrope(.semiBold, size: 16))
                        .foregroundStyle(Color(hex: "FFFFFF"))
                    
//                    Text(league.seasons.first?.start)
                    
                    Button(action:{onSeasonTap()}){
                        HStack{
                            
                            Text(viewModel.selectedSeason?.seasonName ?? "")
                                .font(.manrope(.bold, size: 18))
                                .foregroundStyle(Color(hex: "FFFFFF"))
                            
                            Image(.arrowDownSFill)
                                .font(.manrope(.bold, size: 18))
                                .foregroundStyle(Color(hex: "FFFFFF"))
                            
                            Spacer()
                        }
                    }
                    
                  
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 11)
            
            CustomTabBar(
                            tabs: tabs,
                            selectedTab: $selection,
                            activeColor: Color.white
                        )
           
        }
        .background(content: {GradientView()})
        .onAppear{
            //selectedSeason = league.getCurrentSeason()?.seasonName ?? ""
        }
    }
}
