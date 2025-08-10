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
    @State private var buttonScale: CGFloat = 1.0
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
                    ForEach(0..<viewModel.onBoardingData.count, id: \.self) { index in
                        OnboardingSliderView(sliderItem: viewModel.onBoardingData[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                .onChange(of: viewModel.selectedTab) {  _, newValue in
                    viewModel.decideTabState()
                }
                
                pageIndicators
                
                nextButton
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.befaultBg)
    }
    
    private var pageIndicators: some View {
        HStack(spacing: 10) {
            ForEach(0..<viewModel.onBoardingData.count, id: \.self) { index in
                Capsule()
                    .frame(width: index == viewModel.selectedTab ? 24 : 8, height: 8)
                    .foregroundColor(index == viewModel.selectedTab ? .green : .gray.opacity(0.4))
                    .animation(.easeInOut, value: viewModel.selectedTab)
            }
        }
        .padding(.bottom, 10)
    }
    
    private var nextButton: some View {
        Button(action: nextButtonAction) {
            HStack {
                Text("Next")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(15)
            .scaleEffect(buttonScale)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 40)
        .padding(.bottom, 30)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in buttonScale = 0.95 }
                .onEnded { _ in buttonScale = 1.0 }
        )
    }
    
    private func nextButtonAction() {
        // Implement your next button action here
        // For example:
        if viewModel.selectedTab < viewModel.onBoardingData.count - 1 {
            viewModel.selectedTab += 1
        } else {
            onboarding = false
            pilot.pop()
        }
    }
}
