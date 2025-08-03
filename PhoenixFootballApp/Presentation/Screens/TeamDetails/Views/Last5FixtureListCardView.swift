//
//  Last5FixtureListCardView.swift
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


struct Last5FixtureListCardView:View {
    let ownTeamID:Int
//
    let last5FixtureList:[FixtureDataResponse]
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack(alignment: .leading,spacing:10){
            
            
            Text("Last 5 Matches")
                .body1Bold()
                .foregroundStyle(themeManager.currentTheme.text.sd50)
                .padding(.bottom, 4)
            
            Divider()
                .background(themeManager.currentTheme.background.sd500 )
            
            HStack(alignment: .center){
                
                ForEach(last5FixtureList) { item in
                    Last5FIxtueItem(fixture: item, ownTeamID: ownTeamID)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            
            HStack{
                Spacer()
                
                HStack{
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(themeManager.currentTheme.green.sd500)
                    
                    Text("Win")
                        .captionMedium()
                        .foregroundStyle(themeManager.currentTheme.text.sd200)
                }
                
                HStack{
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(themeManager.currentTheme.red.sd500)
                    
                    Text("Lost")
                        .captionMedium()
                        .foregroundStyle(themeManager.currentTheme.text.sd200)
                }
                
                HStack{
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(themeManager.currentTheme.text.sd800)
                    
                    Text("Draw")
                        .captionMedium()
                        .foregroundStyle(themeManager.currentTheme.text.sd200)
                }
            }
            .padding(.vertical, 4)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 14)
        .padding(.horizontal, 10)
        .background(
            themeManager.currentTheme.background.sd500
        )
        .cornerRadius(10, corners: .allCorners)
        .border(width: 1, color: themeManager.currentTheme.background.sd400 , cornerRadius: 10)
    }
}


struct Last5FIxtueItem:View {
    let fixture:FixtureDataResponse
    let ownTeamID:Int
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            
            MediaView(model: .image(url: getOtherTeamLogo()))
                .frame(width: 32.width(), height: 32.width())
            
            Text("\(fixture.goals.home ?? 0) - \(fixture.goals.away ?? 0)")
                .body2Medium()
                .foregroundStyle(themeManager.currentTheme.text.sd50)
            
        
            switch myTeamWiner(){
            case .draw:
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(themeManager.currentTheme.text.sd200)
            case .lost:
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(themeManager.currentTheme.red.sd500)
            case .win:
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(themeManager.currentTheme.green.sd500)
                
            }
            
            
        }
        .frame(width: 60.width(), height: 96.width(), alignment: .center)
        .background(themeManager.currentTheme.background.sd900 )
        .cornerRadius(55.width(), corners: .allCorners)
        .border(width: 1, color: themeManager.currentTheme.background.sd400 , cornerRadius: 55.width())
    }
    
    
    func getOtherTeamLogo()->String{
        if fixture.teams.home.id == ownTeamID{
            return fixture.teams.away.logo
        }else{
            return fixture.teams.home.logo
        }
    }
    
    
    enum MyTeamResult {
        case win
        case lost
        case draw
    }
    func myTeamWiner() -> MyTeamResult {
        guard let homeGoals = fixture.goals.home, let awayGoals = fixture.goals.away else {
            return .draw // fallback if goals are nil
        }

        let isHomeTeam = fixture.teams.home.id == ownTeamID

        if homeGoals == awayGoals {
            return .draw
        }

        if isHomeTeam {
            return homeGoals > awayGoals ? .win : .lost
        } else {
            return awayGoals > homeGoals ? .win : .lost
        }
    }
}



