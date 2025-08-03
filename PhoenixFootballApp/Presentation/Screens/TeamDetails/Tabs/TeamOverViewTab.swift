//
//  TeamOverViewTab.swift
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

struct TeamOverViewTab:View {
    let ownTeamID:Int
    @EnvironmentObject var teamMatchListViewModel: TeamMatchListViewModel
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 10){
                
                if let nextMatch = teamMatchListViewModel.nextMatch{
                    NextMatchCard(nextMatch: nextMatch)
                }
               
                if teamMatchListViewModel.last5FixtureList.isEmpty == false{
                    Last5FixtureListCardView(ownTeamID: ownTeamID, last5FixtureList: teamMatchListViewModel.last5FixtureList)
                }
               
            }
            .padding(.top, 20)
        }
    }
}


struct TeamStandingsTabView:View {
    
    let standings:[StandingResponse]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 10){
                
                ForEach(standings) { standing in
                    TeamStandingsView(standings: standing.league.standings.first ?? [], leagueName: standing.league.name, leagueLogo: standing.league.logo)
                }
            }
        }
    }
}

struct TeamStandingsView: View {
    
    let standings: [Standing]
    let leagueName:String
    let leagueLogo:String
 
    
    init(standings: [Standing], leagueName: String,  leagueLogo:String) {
        self.standings = standings
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
      
    }
    
    @State var fullStanding:Bool = true
    
    
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        ScrollView{
            VStack{
               
                
                    
                VStack(spacing: 0) {
                    // Header row
                    HStack(spacing: 0) {
//                        Text("#")
//                            .font(.manrope(.medium, size: 12))
//                            .foregroundStyle(Color(hex:"A3A1A9"))
//                            .frame(width: 20, alignment: .center)
                        
                        MediaView(model: .image(url: leagueLogo))
                            .frame(width: 28, height: 28)
                            .padding(.leading, 4)
                        
                        Text(leagueName)
                            .font(.manrope(.medium, size: 12))
                            .foregroundStyle(Color(hex:"A3A1A9"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                        
                        Text("Pl")
                            .font(.manrope(.medium, size: 12))
                            .foregroundStyle(Color(hex:"A3A1A9"))
                            .frame(width: 25, alignment: .center)
                        
                        if fullStanding {
                           
                            Text("W")
                                .font(.manrope(.medium, size: 12))
                                .foregroundStyle(Color(hex:"A3A1A9"))
                                .frame(width: 25, alignment: .center)
                            
                            Text("D")
                                .font(.manrope(.medium, size: 12))
                                .foregroundStyle(Color(hex:"A3A1A9"))
                                .frame(width: 25, alignment: .center)
                            
                            Text("L")
                                .font(.manrope(.medium, size: 12))
                                .foregroundStyle(Color(hex:"A3A1A9"))
                                .frame(width: 25, alignment: .center)
                            
                            Text("+/-")
                                .font(.manrope(.medium, size: 12))
                                .foregroundStyle(Color(hex:"A3A1A9"))
                                .frame(width: 40, alignment: .center)
                        }
                       
                        
                        Text("GD")
                            .font(.manrope(.medium, size: 12))
                            .foregroundStyle(Color(hex:"A3A1A9"))
                            .frame(width: 35, alignment: .center)
                        
                        Text("Pts")
                            .font(.manrope(.medium, size: 12))
                            .foregroundStyle(Color(hex:"A3A1A9"))
                            .frame(width: 30, alignment: .center)
                        
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 7)
                    
                    Divider()
                      .background(Color.white.opacity(0.1))
                      .padding(.bottom, 7)
                    
                    // Team rows
                    LazyVStack(spacing: 0) {
                        ForEach(standings, id: \.team.id) { standing in
                            TeamRow(standing: standing, fullStanding: fullStanding, totalRowCount: standings.count)
                        }
                    }
                }
               
                .padding(.vertical, 16)
                .background(Color(hex:"01080E"))
                .cornerRadius(10)
                .border(width: 1, color: Color(hex: "34393E"), cornerRadius: 10)
                .padding(.bottom, 50)
            }
        }
        
    }
}
