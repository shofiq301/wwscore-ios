//
//  NextMatchCard.swift
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

struct NextMatchCard: View {
    let nextMatch:FixtureDataResponse
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack{
                Text("Next match")
                    .body1Bold()
                    .foregroundStyle(themeManager.currentTheme.text.sd50)
                
                Spacer()
                
                //28 NOV 2023 , or today , tomorrow
//                Text(nextMatch.fixture.getStartDate(dateFormat: ""))
//                    .body2Medium()
//                    .foregroundStyle(themeManager.currentTheme.text.sd50)
                
                Text(nextMatch.fixture.date.formattedRelativeOrFullDate())
                    .body2Medium()
                    .foregroundStyle(themeManager.currentTheme.text.sd50)
                
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 14)
            
            Divider()
                .background(
                    themeManager.currentTheme.background.sd400
                )
                .padding(.bottom, 14)
                .padding(.horizontal, 14)
            
            
            HStack{
                VStack{
                    Spacer()
//                    Text("21:00")
                  Text(nextMatch.fixture.getStartDate(dateFormat: "HH:mm"))
                        .body2Regular()
                        .foregroundStyle(.white)
                    
                    Text(nextMatch.fixture.status.short.rawValue)
                        .body2Regular()
                        .foregroundStyle(themeManager.currentTheme.text.sd600)
                    Spacer()
                }
                .frame(width: 48.width())
//                .padding(.vertical, 8)
                .background(
                    themeManager.currentTheme.background.sd400
                )
                
            
//                Spacer()
                
                VStack(spacing:6){
                    
                    HStack(spacing: 4){
                        MediaView(model: .image(url: nextMatch.teams.home.logo))
                            .frame(width: 16, height: 16)
                        
                        Text(nextMatch.teams.home.name)
                            .body1Semebold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    HStack(spacing: 4){
                        MediaView(model: .image(url: nextMatch.teams.away.logo))
                            .frame(width: 16, height: 16)
                        
                        Text(nextMatch.teams.away.name)
                            .body1Semebold()
                            .foregroundStyle(.white)
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                
            }
            .background(
                Color(hex:"34393E").opacity(0.4)
            )
            .cornerRadius(8, corners: .allCorners)
            .padding(.all, 4)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
//        .padding(.horizontal, 14)
        .background(
            themeManager.currentTheme.background.sd500
        )
        .cornerRadius(10, corners: .allCorners)
        .border(width: 1, color: themeManager.currentTheme.background.sd400 , cornerRadius: 10)
    }
}
extension Date {
    func formattedRelativeOrFullDate() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter.string(from: self).uppercased()
        }
    }
}
