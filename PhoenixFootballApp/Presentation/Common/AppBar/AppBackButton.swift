//
//  AppBackButton.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/2/25.
//


import SwiftUI

struct AppBackButton:View {
    let action:()->Void
    var body: some View {
        Button(action:action){
            VStack{
                Image(.backIcon)
                    .renderingMode(.template)
                    .foregroundColor(.white)
                
            }
        }
    }
}
