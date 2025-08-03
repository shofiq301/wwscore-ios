//
//  SettingsHomeScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/7/25.
//

import SwiftUI
import PhoenixUI

struct SettingsHomeScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                
                SettingsOptionButton(title: "Notification") {
                    
                }
                SettingsOptionButton(title: "Terms & Condition") {
                    
                }
                SettingsOptionButton(title: "Rate Us") {
                    
                }
                SettingsOptionButton(title: "Share") {
                    
                }
                SettingsOptionButton(title: "Contact Us") {
                    
                }
            }
        }
        .padding(.horizontal, 16)
        .appBar(title: "About Footy Strike", trailing: {
            
        }, leading: {
            
        })
        
        
    }
}


struct SettingsOptionButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: {action()}) {
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(.manrope(.medium, size: 16))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                }
                .padding(.vertical, 16)
                
                Divider()
                    .background(Color.white.opacity(0.3)) // Adjust opacity if needed
            }
        }
    }
}
