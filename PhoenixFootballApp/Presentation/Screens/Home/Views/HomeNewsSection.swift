//
//  HomeNewsSection.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//



import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct HomeNewsSection:View {
    @StateObject  var newsViewModel: NewsViewModel = NewsViewModelBindings().getDependencyForHome()
    var body: some View {
        VStack(spacing: 20){
            HeaderWithViewAll(title: "Trending News") {
                
            }
            
            NewsHorizontalList(list: newsViewModel.recentNewsList)
                .padding(.bottom, 16)
            
            NewsVerticalList(list: newsViewModel.trendingNewsList)
        }
        .padding(.horizontal, 16)
    }
}
