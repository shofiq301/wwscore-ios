//
//  HeaderWithViewAll.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//


import Combine
import SUIRouter
import SwiftUI
import XSwiftUI


struct HeaderWithViewAll:View {
    let title: String
    let onViewAll: () -> Void
    var body: some View {
        HStack{
            Text(title)
                .font(.manrope(.semiBold, size: 20))
                .foregroundStyle(Color.white)
            
            Spacer()
            Button(action:{onViewAll()}){
                Text("View All")
                    .font(.manrope(.medium, size: 14))
                    .foregroundStyle(Color(hex: "1976D2"))
            }
           
        }
    }
}

#Preview {
    VStack{
        Spacer()
        HeaderWithViewAll(title: "Match List") {
            
        }
        Spacer()
    }
    .padding(.horizontal, 16)
    .background(ThemeColors.backgroundColor.color)
}
