//
//  LeagueDetailsScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/2/25.
//

import SwiftUI
import APIFootball
import XSwiftUI
import EasyXConnect
import EasyX
import SwifterSwift
import SDWebImageSwiftUI
import SDWebImage
import SUIRouter
import PhoenixUI
import InfiniteScrollView

struct LeagueDetailsScreen:View {
    let league:LeagueData
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    @EnvironmentObject var themeManager: ThemeManager
    
    @StateObject var viewModel: LeagueDetailsViewModel
    @StateObject  var newsViewModel: NewsViewModel
    @State var isSheetPresented = false
    @State var selectedTab: Int = 0
    
    init(league: LeagueData) {
        self.league = league
        _viewModel = StateObject(
            wrappedValue: LeagueDetailsViewModelBindings(leagueID: league.league.id)
                .getDependency()
        )
        
        _newsViewModel = StateObject(wrappedValue: NewsViewModelBindings().getDependencyForLeague(leagueId: league.league.id ))
        
    }
    
    var body: some View {
        VStack{
            LeagueInfo(league: league, selection: $selectedTab){
                isSheetPresented.toggle()
            }
            .padding(.bottom, 10)
            
            TabView(selection: $selectedTab) {
                LeagueFixturesView()
                    .tag(0)
                
                LeagueStandingsView(standings: viewModel.standingsList)
                .tag(1)
                VStack{
                    InfiniteList(
                      data: $newsViewModel.trendingNewsList,
                      loadingView: {
                        ProgressView()
                          .foregroundColor(.white)
                      },
                      scrollEnable: true,
                      loadMore: {
                         await newsViewModel.loadMoreTrendingNews(leagueId: league.league.id)
                       // loadMore()
                        print("load more")
                      }
                    ) { item in
                        NewsHorizontalCardSmallView(news: item)
                    }
                }
                .padding(.horizontal, 16)
                .tag(2)
//                VStack{
//                }
//                .tag(3)

                // Add more tab body views for other tabs if needed.
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
   
         
            
//            Spacer()
        }
        .frame(maxWidth: .infinity)
//        .background(Color(hex: "000306"))
        .background(themeManager.currentTheme.backgroundDefault)
        .sheet(isPresented: $isSheetPresented){
            if #available(iOS 16.0, *) {
                SeasonListView(model: league, isSheetPresented: $isSheetPresented)
                    .presentationDetents([.height(200), .medium, .large])
                    .presentationDragIndicator(.automatic)
            }else{
                SeasonListView(model: league, isSheetPresented: $isSheetPresented)
            }
          
            
        }
        .environmentObject(viewModel)
        
        
    }
}


