//
//  OnboardingNavbarView.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 9/3/25.
//

import SwiftUI

struct OnboardingNavbarView: View {
    @Binding var shouldShowBackButton: Bool
    let backAction: () -> Void
    let skipAction: () -> Void
    var body: some View {
        HStack {
            if shouldShowBackButton {
                Button(action: backAction) {
                    Image("backIcon")
                        .resizable()
                        .renderingMode(.template)
                        .font(.manrope(.regular, size: 14))
                        .fontWeight(.regular)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.defaultIcon)
                }
            }
            Spacer()
            Button(action: skipAction) {
                Text("Skip")
                    .font(.manrope(.regular, size: 14))
                    .foregroundColor(.defaultText)
            }
        }.padding(.horizontal)
    }
}
