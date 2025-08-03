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
                Image("Splash/splashTitle")
                    .padding(.top)
                Spacer()
                    .frame(height: 96)
                Image("Splash/splashLogo")
                    .padding(.top)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.splashBackground)
        }.ignoresSafeArea()
    }
}

#Preview {
    SplashScreenView()
}
