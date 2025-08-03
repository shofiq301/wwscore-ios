//
//  FixtureHeadToHeadCard.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/24/25.
//



import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct FixtureHeadToHeadCard: View {
    let h2hList: [FixtureDataResponse]
    let match: FixtureDataResponse

    var homeTeam: Away? {
        match.teams.home
    }

    var awayTeam: Away? {
        match.teams.away
    }
    @EnvironmentObject var themeManager: ThemeManager
    var stats: (homeWins: Int, awayWins: Int, draws: Int) {
        var homeWins = 0, awayWins = 0, draws = 0

        for h2h in h2hList {
            let isHomePerspective = h2h.teams.home.id == match.teams.home.id
            guard let homeGoals = h2h.goals.home, let awayGoals = h2h.goals.away else {
                continue
            }

            let homeTeamGoals = isHomePerspective ? homeGoals : awayGoals
            let awayTeamGoals = isHomePerspective ? awayGoals : homeGoals

            if homeTeamGoals > awayTeamGoals {
                homeWins += 1
            } else if homeTeamGoals < awayTeamGoals {
                awayWins += 1
            } else {
                draws += 1
            }
        }
        return (homeWins, awayWins, draws)
    }

    var totalMatches: Int {
        stats.homeWins + stats.awayWins + stats.draws
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                if let home = homeTeam {
                    TeamIcon(name: home.name, logo: home.logo)
                }

                Spacer()

                Text("Previous matches")
                    .body2Medium()
                    .foregroundStyle(themeManager.currentTheme.text.sd50)

                Spacer()

                if let away = awayTeam {
                    TeamIcon(name: away.name, logo: away.logo)
                }
            }
            
            Divider()
                .foregroundStyle(themeManager.currentTheme.background.sd400)
            

//            ProgressView(
//                value: Float(stats.homeWins),
//                total: Float(totalMatches)
//            )
//                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
//                .background(
//                    ProgressView(value: Float(stats.awayWins), total: Float(totalMatches))
//                        .progressViewStyle(LinearProgressViewStyle(tint: .lightBlue))
//                        .scaleEffect(x: -1, y: 1, anchor: .center) // Flip for right-alignment
//                       
//                )
//                .background(
//                    ProgressView(value: Float(stats.draws), total: Float(totalMatches))
//                        .progressViewStyle(LinearProgressViewStyle(tint: .red))
//                        .scaleEffect(x: -1, y: 1, anchor: .center) // Flip for right-alignment
//                )
//                
//                .frame(height: 8)
//                .cornerRadius(4)
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    // Home wins
                    Rectangle()
                        .fill(themeManager.currentTheme.primary.sd500)
                        .frame(width: (geometry.size.width ) * CGFloat(homeWinsPercent) / 100.0)
                    
                    // Draws
                    Rectangle()
                        .fill(themeManager.currentTheme.background.sd400)
                        .frame(width:(geometry.size.width ) * CGFloat(drawsPercent) / 100.0)
                    
                    // Away wins
                    Rectangle()
                        .fill(themeManager.currentTheme.secondary.sd500)
                        .frame(width: (geometry.size.width) * CGFloat(awayWinsPercent) / 100.0)
                        .cornerRadius(4, corners: [.topRight, .bottomRight])
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(height: 8)
            .cornerRadius(4, corners: .allCorners)

            HStack {
                StatBox(
                    title: "Wins",
                    value: stats.homeWins,
                    percentage: homeWinsPercent,
                    color: themeManager.currentTheme.primary.sd500,
                    textColor: .white
                )
                Spacer()
                StatBox(
                    title: "Draws",
                    value: stats.draws,
                    percentage: drawsPercent,
                    color: themeManager.currentTheme.background.sd400,
                    textColor: Color.white
                )
                Spacer()
                StatBox(
                    title: "Wins",
                    value: stats.awayWins,
                    percentage: awayWinsPercent,
                    color: themeManager.currentTheme.secondary.sd500,
                    textColor: themeManager.currentTheme.background.sd900
                )
            }
        }
        
        .padding(.all, 20)
        .background(themeManager.currentTheme.background.sd500)
        .border(width: 1, color: themeManager.currentTheme.background.sd400, cornerRadius: 16)
    }
}

// MARK: - Supporting Views and Extensions

extension FixtureHeadToHeadCard {
    var homeWinsPercent: Int {
        guard totalMatches > 0 else { return 0 }
        return Int(Double(stats.homeWins) / Double(totalMatches) * 100)
    }

    var awayWinsPercent: Int {
        guard totalMatches > 0 else { return 0 }
        return Int(Double(stats.awayWins) / Double(totalMatches) * 100)
    }

    var drawsPercent: Int {
        guard totalMatches > 0 else { return 0 }
        return Int(Double(stats.draws) / Double(totalMatches) * 100)
    }
}

struct TeamIcon: View {
    let name: String
    let logo: String

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: logo)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 28, height: 28)
            .clipShape(Circle())
        }
    }
}

struct StatBox: View {
    let title: String
    let value: Int
    let percentage: Int
    let color: Color
    let textColor: Color
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        HStack {
            Text("\(value)")
                .h5Semibold()
                .foregroundColor(textColor)
                .frame(width: 36, height: 36, alignment: .center)
                .background(color)
                .cornerRadius(5)
            
            VStack(alignment: .leading){
                Text(title)
                    .body2Medium()
                    .foregroundColor(.white)
                Text("\(percentage)%")
                    .captionMedium()
                    .foregroundColor(themeManager.currentTheme.text.sd500)
            }
        }
//        .frame(maxWidth: .infinity)
    }
}
