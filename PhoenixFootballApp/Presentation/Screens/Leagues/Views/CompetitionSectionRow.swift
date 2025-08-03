//
//  CompetitionSectionRow.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 4/21/25.
//


import SwiftUI
import XSwiftUI
import PhoenixUI
import APIFootball

struct CompetitionSectionRow: View {
    let section: String
    let isExpanded: Bool
    let countryIcon: String?
    let leagues: [LeagueDetailsData]
    let toggleExpand: () -> Void
    let onLeagueSelected: (LeagueDetailsData) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 16) {
                // For simplicity, using a placeholder icon
                // In a real app, you'd determine the icon based on the section
                
                if let countryIcon = countryIcon{
                    
                    MediaView(model: .image(url: countryIcon))
                        .frame(width: 28, height: 28)
                    
                }else{
                    let iconName = iconForSection(section)
                    let iconColor = colorForSection(section)
                    
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(iconColor)
                }
               
                
                Text(section)
                    .font(.manrope(.medium, size: 14))
                    .foregroundStyle(Color(hex: "C2C1C8"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            
                
                Image(systemName: "chevron.up")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                  .rotationEffect(.degrees(isExpanded ? 0 : 180))
                  .animation(.spring(), value: isExpanded)
            }
            .padding(.horizontal)
            .frame(height: 44)
            .onTapGesture {
                toggleExpand()
            }
            
            
            if isExpanded{
                ForEach(leagues, id: \.id) { league in
                    LeagueRow(league: league){
                        onLeagueSelected(league)
                    }
                }
            }
        }
    }
    
    func iconForSection(_ section: String) -> String {
        switch section {
        case "International-National team":
            return "c.circle.fill"
        case "Argentina", "Portugal", "Korea", "Brazil", "China":
            return "p.circle.fill"
        case "Champions League":
            return "c.circle.fill"
        case "LaLiga":
            return "l.circle.fill"
        case "England":
            return "e.circle.fill"
        default:
            return "globe"
        }
    }
    
    func colorForSection(_ section: String) -> Color {
        switch section {
        case "Champions League":
            return Color(#colorLiteral(red: 0.1, green: 0.1, blue: 0.5, alpha: 1))
        case "LaLiga":
            return Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        case "Argentina", "Portugal", "Korea", "Premier League":
            return Color(#colorLiteral(red: 0.4, green: 0, blue: 0.8, alpha: 1))
        case "England", "Brazil", "China", "EUROPA League":
            return Color(#colorLiteral(red: 1, green: 0.4, blue: 0, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.4, green: 0, blue: 0.8, alpha: 1))
        }
    }
}
