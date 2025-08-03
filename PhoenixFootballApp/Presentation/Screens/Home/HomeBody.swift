//
//  HomeBody.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/12/25.
//

import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct HomeBody: View {

  @State private var selectedDate = Date()

  @StateObject var homeViewModel: HomeViewModel = HomeViewModelBindings().getDependency()
  @State private var fetchTask: Task<(), Never>?

  @State var isLoading: Bool = false

  var body: some View {
    ZStack {

      HomeHeaderViewContainer(selectedDate: $selectedDate) {

          if isLoading{
              ProgressView()
                  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                  .frame(height: .screenHeight - 200)
          } else{
              
            LazyVStack {
              TabsWithIcon()
                .padding(.top, 26)
                .padding(.bottom, 32)
              DateNavigationBar(selectedDate: $selectedDate)
                .padding(.bottom, 32)
              MatchCarousel() 
                .padding(.bottom, 20)
              HomeMatchListSection()
                .padding(.bottom, 32)

              PopulerLeagueSection()
                .padding(.bottom, 32)
              HomeNewsSection()
                .padding(.bottom, 62)
            }
          }
          
      }

    }
    .onChange(of: selectedDate) { newValue in
      fetchTask?.cancel()
      fetchTask = Task {
//        isLoading = true
        await homeViewModel.getMatchesByDate(date: newValue)
//        isLoading = false
      }
    }
    .background(ThemeColors.backgroundColor.color)
    .environmentObject(homeViewModel)
    .onAppear {
      if homeViewModel.fixtureList.isEmpty {
        fetchTask?.cancel()
        fetchTask = Task {
          isLoading = true
          await homeViewModel.getMatchesByDate(date: selectedDate)
          isLoading = false
        }
      }
    }
  }
}

#Preview{
  VStack {
    PopulerLeagueSection()
  }
  .background(ThemeColors.backgroundColor.color)
}
