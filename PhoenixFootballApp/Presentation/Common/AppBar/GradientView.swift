//
//  GradientView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/2/25.
//


import SwiftUI
import XSwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(hex: "#001122"),
                Color(hex: "#014149").opacity(0.28)  // 28% opacity
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
//        .ignoresSafeArea()     // if you want it full‐screen
    }
}
