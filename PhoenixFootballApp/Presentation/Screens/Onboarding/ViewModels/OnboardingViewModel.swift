//
//  OnboardingViewModel.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 9/3/25.
//
import Foundation
import Combine
final class OnboardingViewModel: ObservableObject {
    var onBoardingData: [OnboadingViewItem] = []
    @Published var selectedTab = 0
    @Published var tabState: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.onBoardingData = OnboadingViewItem.items
        decideTabState()
    }
    func decideTabState() {
        if selectedTab == 0 {
            tabState = false
        } else if selectedTab > 0 && selectedTab < onBoardingData.count - 1 {
            tabState = true
        } else if selectedTab == onBoardingData.count - 1 {
            tabState = true
        }
    }
}
