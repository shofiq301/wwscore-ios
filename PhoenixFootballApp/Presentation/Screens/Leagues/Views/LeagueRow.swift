//
//  LeagueRow.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 4/21/25.
//
import SwiftUI
import XSwiftUI
import PhoenixUI
import APIFootball

struct LeagueRow: View {
    let league: LeagueDetailsData
    let action: () -> Void
    var body: some View {
        Button(action: action){
            HStack(spacing: 16) {
               
                MediaView(model: .image(url: league.logo))
                    .frame(width: 28, height: 28)
                
                Text(league.name)
                    .font(.manrope(.medium, size: 14))
                    .foregroundStyle(Color(hex: "C2C1C8"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
            .frame(height: 44)
        }
        .buttonStyle(.plain)
    }
}
