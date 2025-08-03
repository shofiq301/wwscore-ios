//
//  TeamFormationCard.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/18/25.
//



import SwiftUI

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI


struct TeamFormationCard: View {
    let homeTeam: LineUpsData
    let awayTeam: LineUpsData
   
    let homePlayers: [StartXi]
    let homeFormationsList: [Int]
    
    let awayPlayers: [StartXi]
    let awayFormationsList: [Int]
    @EnvironmentObject var themeManager: ThemeManager
    init(homeTeam: LineUpsData, awayTeam: LineUpsData) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
       
        self.homePlayers = homeTeam.getSortedStartXI()
        self.homeFormationsList = homeTeam.getFormationList()
        
        self.awayPlayers = awayTeam.getSortedStartXI()
        self.awayFormationsList = awayTeam.getFormationList()
    }
   
    var body: some View {
        if let homeFormation = homeTeam.formation, let awayFormation = awayTeam.formation {
            VStack(spacing: 0) {
                // Header showing both team formations
//                HStack {
//                    Text(homeTeam.team.name)
//                        .fontWeight(.medium)
//                        .foregroundColor(.white)
//                    
//                    Spacer()
//                    
//                    Text("\(homeFormation) vs \(awayFormation)")
//                        .fontWeight(.regular)
//                        .foregroundColor(.white)
//                    
//                    Spacer()
//                    
//                    Text(awayTeam.team.name)
//                        .fontWeight(.medium)
//                        .foregroundColor(.white)
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 12)
//                
                // Field background with players overlay
                Image("lineups-bg")
                    .resizable()
                    .frame(width: 350.width(), height: 652.width())
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        VStack(spacing: 0) {
                            // Home Team (Top Half)
                            VStack(alignment: .center) {
                                if !homePlayers.isEmpty {
                                    setPlayerPosition(
                                        players: homePlayers,
                                        formationsList: homeFormationsList,
                                        pos: 1,
                                        pStart: 0,
                                        isGoalKeeper: true,
                                        isHomeTeam: true
                                    )
                                    .padding(.top, 10)
                                    
                                    ForEach(Array(homeFormationsList.indices), id: \.self) { index in
                                        setPlayerPosition(
                                            players: homePlayers,
                                            formationsList: homeFormationsList,
                                            pos: homeFormationsList[index],
                                            pStart: index,
                                            isGoalKeeper: false,
                                            isHomeTeam: true
                                        )
                                        .padding(.vertical, 5)
                                    }
                                }
                                
                                Spacer() // Push to top half
                            }
//                            .frame(maxHeight: 326.width())
                            .frame(maxHeight: .infinity, alignment: .top)
                            
                            // Away Team (Bottom Half)
                            VStack(alignment: .center) {
                                Spacer() // Push to bottom half
                                
                                if !awayPlayers.isEmpty {
//                                    ForEach(awayFormationsList.indices, id: \.self) { index in
                                    ForEach(Array(awayFormationsList.indices.reversed()), id: \.self) { index in
                                        setPlayerPosition(
                                            players: awayPlayers,
                                            formationsList: awayFormationsList,
                                            pos: awayFormationsList[index],
                                            pStart: index,
                                            isGoalKeeper: false,
                                            isHomeTeam: false
                                        )
                                        .padding(.vertical, 5)
                                    }
                                    
                                    setPlayerPosition(
                                        players: awayPlayers,
                                        formationsList: awayFormationsList,
                                        pos: 1,
                                        pStart: 0,
                                        isGoalKeeper: true,
                                        isHomeTeam: false
                                    )
                                    .padding(.bottom, 10)
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                            .padding(.vertical, 14)
                    )
            }
            .background(themeManager.currentTheme.background.sd500)
//            .mask(Rectangle().cornerRadius(10))
        } else {
            EmptyView()
        }
    }
    
    func setPlayerPosition(
        players: [StartXi],
        formationsList: [Int],
        pos: Int,
        pStart: Int,
        isGoalKeeper: Bool,
        isHomeTeam: Bool
    ) -> some View {
        var p = 0
        if !isGoalKeeper {
            p = 1 // Skip goalkeeper
            for v in 0..<pStart {
                p = p + formationsList[v]
            }
        }
        
        return HStack {
            ForEach(0..<pos, id: \.self) { i in
                if p + i < players.count {
                    PlayerInGroundCard(
                        player: players[p + i],
                        isHomeTeam: isHomeTeam
                    )
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct PlayerInGroundCard: View {
    let player: StartXi
    let isHomeTeam: Bool
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
                .overlay(
                    Circle()
                        .foregroundColor(
                            isHomeTeam ?
                            themeManager.currentTheme.secondary.sd700
                            : themeManager.currentTheme.secondary.sd900) // Different colors for different teams
//                        .padding(.all, 3)
                        .overlay(
                            VStack {
                                if let number = player.player.number {
                                    Text("\(number)")
                                        .body1Medium()
                                        .foregroundColor(.white)
                                } else {
                                    Text("N")
                                        .body1Medium()
                                        .foregroundColor(.white)
                                }
                            }
                        )
                )
            
            Text("\(player.player.name)")
                .captionMedium()
                .foregroundColor(.white)
        }
    }
}
