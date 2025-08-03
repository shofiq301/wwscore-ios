//
//  OnboardingView.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 9/3/25.
//

import SwiftUI
import SUIRouter

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    @Binding var onboarding: Bool
    var body: some View {
        ZStack {
            VStack {
                OnboardingNavbarView(shouldShowBackButton: $viewModel.tabState) {
                    viewModel.selectedTab -= 1
                } skipAction: {
                    onboarding = false
                    pilot.pop()
                }
                TabView(selection: $viewModel.selectedTab){
                    ForEach(0..<viewModel.onBoardingData.count) { index in
                        OnboardingSliderView(sliderItem: viewModel.onBoardingData[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: UIScreen.main.bounds.height * 0.6)
                .onChange(of: viewModel.selectedTab) {  newValue in
                    viewModel.decideTabState()
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.befaultBg)
    }
}
