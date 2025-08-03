//
//  StatisticsTabView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/24/25.
//

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI



struct StatisticsTabView: View {

        
    @EnvironmentObject var viewModel: StatisticsViewModel
    
    @EnvironmentObject var themeManager: ThemeManager
    
    
    let homeTeamID:Int
    let awayTeamID:Int
    
    init(model: FixtureDataResponse ) {
      
        self.homeTeamID = model.teams.home.id
        self.awayTeamID = model.teams.away.id
       
    }
    
    var body: some View {
        VStack{
       
            
            if viewModel.loading == true{
                
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                
            }
            else if viewModel.staticsList.isEmpty == true {
                Text("Stats not available.")
                  .body1Semebold()
                  .foregroundColor(themeManager.currentTheme.textDefault)
                  .padding()
            }
            else{
                ScrollView{
                    VStack{
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Ball Possession"), name: "Ball Possesion", teamB: viewModel.getTeamSTate(teamId: awayTeamID, key: "Ball Possession"))
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Total Shots"), name: "Shots",  teamB: viewModel.getTeamSTate(teamId: awayTeamID, key: "Total Shots"))
                        getState(teamA:  viewModel.getTeamSTate(teamId: homeTeamID, key: "Shots on Goal"), name: "Shots on Goal", teamB: viewModel.getTeamSTate(teamId: awayTeamID, key: "Shots on Goal"))
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Total passes"), name: "Pass", teamB:  viewModel.getTeamSTate(teamId: awayTeamID, key: "Total passes"))
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Passes accurate"), name: "Pass Accuracy", teamB: viewModel.getTeamSTate(teamId: awayTeamID, key: "Passes accurate"))
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Fouls"), name: "Foul", teamB:  viewModel.getTeamSTate(teamId: awayTeamID, key: "Fouls"))
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Yellow Cards"), name: "Yellow Card", teamB:  viewModel.getTeamSTate(teamId: awayTeamID, key: "Yellow Cards"))
                        getState(teamA:viewModel.getTeamSTate(teamId: homeTeamID, key: "Red Cards"), name: "Red Card", teamB: viewModel.getTeamSTate(teamId: awayTeamID, key: "Red Cards"))
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Offsides"), name: "Offside", teamB: viewModel.getTeamSTate(teamId: awayTeamID, key: "Offsides"))
                        getState(teamA: viewModel.getTeamSTate(teamId: homeTeamID, key: "Corner Kicks"), name: "Corner", teamB: viewModel.getTeamSTate(teamId: awayTeamID, key: "Corner Kicks"))
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 32)
                    .frame(maxWidth: .infinity, alignment: .top)
                }
            }
            
            
        }
    }
    
   
    @ViewBuilder
    func getState(teamA: StatisticValue, name: String, teamB: StatisticValue) -> some View {
        
        // Helper function to convert StatisticValue to Double
        func getValue(_ stat: StatisticValue) -> Double {
            switch stat {
            case .integer(let intValue):
                return Double(intValue)
            case .string(let stringValue):
                // Try to parse string as number, fallback to 0
                let initValue = stringValue.replacing("%", with: "")
                return Double(initValue) ?? 0.0
            case .null:
                return 0.0
            }
        }
        
      
        
        let teamAValue = getValue(teamA)
        let teamBValue = getValue(teamB)
        let total = teamAValue + teamBValue
        
        // Calculate percentages, handle division by zero
        let teamAPercentage: Double = total > 0 ? teamAValue / total : 0.1
        let teamBPercentage: Double = total > 0 ? teamBValue / total : 0.1
        
       return  VStack(spacing: 4) {
            HStack {
                Text("\(teamA)")
                    .body2Medium()
                    .foregroundColor(Color(hex: "FFFFFF"))
                
                Spacer()
                Text(name)
                    .body2Medium()
                    .foregroundColor(Color(hex: "FFFFFF"))
                
                Spacer()
                Text("\(teamB)")
                    .body2Medium()
                    .foregroundColor(Color(hex: "FFFFFF"))
            }
            
            // Progress bars
            HStack(spacing: 8) {
                // Team A progress bar
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(themeManager.currentTheme.text.sd900)
                        .frame(height: 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(total <= 0 ? Color.clear : teamAPercentage > teamBPercentage ? themeManager.currentTheme.primary.sd500 : themeManager.currentTheme.secondary.sd700)
                                .frame(width: geometry.size.width * teamAPercentage)
                            , alignment: .trailing)
                }
                .frame(height: 8)
                
                // Team B progress bar
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(themeManager.currentTheme.text.sd900)
                        .frame(height: 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .fill( total <= 0 ? Color.clear : teamBPercentage > teamAPercentage ? themeManager.currentTheme.primary.sd500 : themeManager.currentTheme.secondary.sd700)
                                .frame(width: geometry.size.width * teamBPercentage)
                            , alignment: .leading)
                }
                .frame(height: 8)
            }
            .frame(height: 8)
        }
        .padding(.vertical, 8)
    }
    
}

