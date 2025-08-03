//
//  MatchesHomeView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//

import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct MatchesHomeView: View {

  @StateObject var matchViewModel: MatchListViewModel = MatchListViewModelBindings().getDependency()

  @State var selectedDate = Date()
  @State private var fetchTask: Task<(), Never>?  // Added for task management
@State var isLoading: Bool = false
  var body: some View {
    VStack(spacing: 0) {

      HomeHeaderViewContainer(selectedDate: $selectedDate) {
        LazyVStack {
          TabsWithIcon()
            .padding(.top, 26)
            .padding(.bottom, 32)
          DateNavigationBar(selectedDate: $selectedDate)
          .padding(.bottom, 32)

          MatchListSection(isLoading: $isLoading)
            .padding(.bottom, 32)

        }
      }

    }
    .onAppear {
      if matchViewModel.fixtureList.isEmpty {
        fetchTask?.cancel()
        fetchTask = Task {
            isLoading = true
          await matchViewModel.getMatchesByDate(date: selectedDate)
            isLoading = false
        }
      }
    }
    .onChange(of: selectedDate) { newValue in
      fetchTask?.cancel()
      fetchTask = Task {
          isLoading = true
        await matchViewModel.getMatchesByDate(date: newValue)
          isLoading = false
      }
    }
    .background(ThemeColors.backgroundColor.color)
    .environmentObject(matchViewModel)
  }
}

struct HomeHeaderViewContainer<Content: View>: View {
  @ViewBuilder
  private let content: () -> Content
    @Binding  var selectedDate:  Date
//  init(@ViewBuilder content: @escaping () -> Content) {
//    self.content = content
//  }
    
    init(selectedDate: Binding<Date>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self._selectedDate = selectedDate
       
    }
    
  @State var showCalender: Bool = false
  var body: some View {
    VStack(spacing: 0) {
      HomeHeader {
        showCalender.toggle()
      }
      .padding(.horizontal, 16)
      .padding(.bottom, 20)
      ZStack(alignment: .top) {
        ScrollView {
          content()
        }

        if showCalender {
          CustomCalendar(
            selectedDate: $selectedDate,
            onDateSelected: { date in
              showCalender = false

              // selectedDate = date
              print("Selected date: \(formattedDate(date))")
            }
          )
          .background(ThemeColors.backgroundColor.color)
        }
      }
    }

  }

  private func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
}

struct MatchListSection: View {
    @Binding var isLoading: Bool
  @EnvironmentObject var matchViewModel: MatchListViewModel
  var body: some View {
    VStack(spacing: 20) {
        if isLoading{
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
        }else{
            ForEach(Array(matchViewModel.fixtureListByLeague.enumerated()), id: \.1.0) { index, item in
              let (leagueName, fixtures) = item
              MatchesByLeagueView(leagueName: leagueName, fixtures: fixtures, isExpanded: index < 2)
            }
        }
     
    }

  }
}
