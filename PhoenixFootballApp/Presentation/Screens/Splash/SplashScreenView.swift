//
//  SplashScreenView.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 9/3/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var active: Bool = false
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Image("Splash/splash-icon")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background {
                Image("Splash/Splash screen")
                    .resizable()
                    .scaledToFill()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashScreenView()
}
