//
//  NewsListHome.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/7/25.
//

import PhoenixUI
import SwiftUI
import XSwiftUI
import InfiniteScrollView

struct NewsListHome: View {
    
    @StateObject  var newsViewModel: NewsViewModel = NewsViewModelBindings().getDependency()
    @State var selectedID : Int? = nil
  var body: some View {

    VStack(spacing: 24) {
        SportsCategoryTabs(categories: newsViewModel.allCategory){ leagueID in
            
            Task{
                if let id = leagueID{
                    let lID = id == NewsCategoryModel.all.datumID ? nil : id
                    selectedID = lID
                   await newsViewModel.getRecentNews(leagueId: lID)
                   await newsViewModel.getTrendingNews(leagueId: lID)
                }
                
            }
        }
        .padding(.horizontal, 16)
      ScrollView {
          VStack{
              NewsHorizontalList(list: newsViewModel.recentNewsList)
            VStack(spacing: 24) {
              
                
                VStack(alignment: .leading, spacing:0){
                    
                    Text("Trending News")
                        .font(.manrope(.semiBold, size: 20))
                        .foregroundStyle(.white)
                        .padding(.bottom, 20)
                    
                    
                   // NewsVerticalList(list: newsViewModel.trendingNewsList)
                    
                    InfiniteList(
                      data: $newsViewModel.trendingNewsList,
                      loadingView: {
                        ProgressView()
                          .foregroundColor(.white)
                      },
                      scrollEnable: false,
                      loadMore: {
                         await newsViewModel.loadMoreTrendingNews(leagueId: selectedID)
                       // loadMore()
                        print("load more")
                      }
                    ) { item in
                        NewsVerticalCardView(news: item)
                    }
                   
                    
                }
                .padding(.horizontal, 16)
                

            }
          }
          

      }.refreshable {

          Task{
              if let id = selectedID{
                  let lID = id == NewsCategoryModel.all.datumID ? nil : id
                 await newsViewModel.getRecentNews(leagueId: lID)
                 await newsViewModel.getTrendingNews(leagueId: lID)
              }
          }
        }
     

    }
    .padding(.top, 24)
    .appBar(
      title: "News",
      trailing: {

      },
      leading: {

      })
    .task {
       //await newsViewModel.getAllNews()
    }
  }

}


struct NewsHorizontalList:View {
    let list:[NewsDoc]
    var body: some View {
        ScrollView(.horizontal) {
          HStack(spacing: 16) {
           
              ForEach(list) { l in
                  NewsHorizontalCardView(news: l)
              }
          }
          .padding(.leading, 16)
        }
        .frame(maxWidth: .screenWidth)
    }
}


struct NewsVerticalList:View {
    let list:[NewsDoc]
    var body: some View {
        VStack(spacing: 16){
            
           
            ForEach(list) { l in
                NewsVerticalCardView(news: l)
            }
            
           
           
        }
    }
}

#Preview{
  ContentView()
}

