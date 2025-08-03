//
//  LeagueStandingsView.swift
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


struct LeagueStandingsView: View {
    
    let standings: [Standing]
    
    let withTaggleButton:Bool
    
    init(standings: [Standing], withTaggleButton: Bool = true ) {
        self.standings = standings
        self.withTaggleButton = withTaggleButton
    }
    
    @State var fullStanding:Bool = false
    
    
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        ScrollView{
            VStack{
                if withTaggleButton{
                    ToggleSwitch(isFullMode: $fullStanding)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 7)
                        .padding(.bottom, 10)
                }
                
                    
                VStack(spacing: 0) {
                    // Header row
                    HStack(spacing: 0) {
                        Text("#")
                            .font(.manrope(.medium, size: 12))
                            .foregroundStyle(Color(hex:"A3A1A9"))
                            .frame(width: 20, alignment: .center)
                        
                        Text("TEAM")
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

struct TeamRow: View {
    let standing: Standing
    let fullStanding:Bool
    let totalRowCount:Int
    var body: some View {
        HStack(spacing: 0) {
            
            Rectangle()
                .fill(
                    standing.rank <= 2 ? Color(hex:"1976D2") :
                    (standing.rank > totalRowCount - 2 ? Color(hex:"E55A53") : Color.clear)
                )
                .frame(width: 3, height: 40)
                .cornerRadius(5, corners: [.topRight, .bottomRight])
                .padding(.trailing, 6)
            
            Text(String(format: "%02d", standing.rank))
                .font(.manrope(.medium, size: 12))
                .foregroundStyle(Color(hex:"F7F7F8"))
                .frame(width: 20, alignment: .center)
            
            HStack(spacing: 10) {
                // Team badge - in a real app, you'd load this from a URL
                AsyncImage(url: URL(string: standing.team.logo)) { image in
                    image
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: "shield.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(standing.team.name == "Manchester United" ? .red : .white)
                        .background(standing.team.name == "Manchester United" ? .white : .black)
                        .clipShape(Circle())
                }
                
                // Team name
                Text(standing.team.name)
                    .font(.manrope(.medium, size: 12))
                    .foregroundStyle(Color(hex:"F7F7F8"))
                    .font(.system(size: 14, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
            
            Text("\(standing.all.played ?? 0)")
                .font(.manrope(.medium, size: 12))
                .foregroundStyle(Color(hex:"F7F7F8"))
                .frame(width: 25, alignment: .center)
            if fullStanding{
                Text("\(standing.all.win)")
                    .font(.manrope(.medium, size: 12))
                    .foregroundStyle(Color(hex:"F7F7F8"))
                    .frame(width: 25, alignment: .center)
                
                Text("\(standing.all.draw)")
                    .font(.manrope(.medium, size: 12))
                    .foregroundStyle(Color(hex:"F7F7F8"))
                    .frame(width: 25, alignment: .center)
                
                Text("\(standing.all.lose)")
                    .font(.manrope(.medium, size: 12))
                    .foregroundStyle(Color(hex:"F7F7F8"))
                    .frame(width: 25, alignment: .center)
                
                Text("\(standing.all.goals.goalsFor)-\(standing.all.goals.against)")
                    .font(.manrope(.medium, size: 12))
                    .foregroundStyle(Color(hex:"F7F7F8"))
                    .frame(width: 40, alignment: .center)
            }
           
            
            Text(standing.goalsDiff > 0 ? "+\(standing.goalsDiff)" : "\(standing.goalsDiff)")
                .font(.manrope(.medium, size: 12))
//                .foregroundStyle(Color(hex:"F7F7F8"))
                .frame(width: 35, alignment: .center)
                .foregroundColor(standing.goalsDiff > 0 ? .green : .red)
            
            Text("\(standing.points)")
                .font(.manrope(.medium, size: 12))
                .foregroundStyle(Color(hex:"F7F7F8"))
                .frame(width: 30, alignment: .center)
                .padding(.trailing, 7)
        }
        .padding(.vertical, 1)
    }
}

// Preview
struct LeagueStandingsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            LeagueStandingsView(standings: [])
        }
    }
}

struct ToggleSwitch: View {
    @Binding var isFullMode: Bool
    
    let shortText: String
    let fullText: String
    
    init(isFullMode: Binding<Bool>, shortText: String = "Short", fullText: String = "Full") {
        self._isFullMode = isFullMode
        self.shortText = shortText
        self.fullText = fullText
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // Short Button
            Button(action: {
                if isFullMode {
                    isFullMode = false
                }
            }) {
                Text(shortText)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .frame(minWidth: 60)
                    .frame(minHeight: 42)
            }
            .foregroundColor(isFullMode ? .gray : .white)
            .background(isFullMode ? Color.clear : Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            Spacer()
            // Full Button
            Button(action: {
                if !isFullMode {
                    isFullMode = true
                }
            }) {
                Text(fullText)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .frame(minWidth: 70)
                    .frame(minHeight: 42)
            }
            .foregroundColor(isFullMode ? .white : .gray)
            .background(isFullMode ? Color.blue : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .frame(width: 150)
        .padding(.all, 6)
        .background(Color(hex:"01080E"))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color(hex:"34393E"), lineWidth: 1)
        )
    }
}
