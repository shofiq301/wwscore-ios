//
//  SportsOnboardingView.swift
//  PhoenixFootballApp
//
//  Created by Rafiul Hasan on 8/4/25.
//

import SwiftUI

struct SportsOnboardingView: View {
    
    @State private var selectedSports: Set<String> = []
    
    let sports = [
        SportSelectionRow(icon: "football", title: "Football", isSelected: true),
        SportSelectionRow(icon: "Basketball", title: "Basketball", isSelected: false),
        SportSelectionRow(icon: "baseball", title: "Baseball", isSelected: false)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Sports selection
            VStack(spacing: 4) {
                ForEach(sports, id: \.title) { sport in
                    SportSelectionRow(icon: sport.icon, title: sport.title, isSelected: selectedSports.contains(sport.title))
                        .onTapGesture {
                            if selectedSports.contains(sport.title) {
                                selectedSports.remove(sport.title)
                        } else {
                            selectedSports.insert(sport.title)
                        }
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.onboardWelcomeText)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.onboardWelcomeText, lineWidth: 1)
            )
        }
    }
}

struct SportSelectionRow: View {
    
    let icon: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 38, height: 38)
            
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.onboardText)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 22))
            } else {
                Image(systemName: "star")
                    .foregroundColor(.gray)
                    .font(.system(size: 22))
            }
        }
        .padding()
        .cornerRadius(10)
    }
}

struct SportsOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SportsOnboardingView()
                .preferredColorScheme(.light)
                .padding()
                .background(Color.onboardBG)
            
            SportsOnboardingView()
                .preferredColorScheme(.dark)
                .padding()
                .background(Color.onboardBG)
        }
    }
}
