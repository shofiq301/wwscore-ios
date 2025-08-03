//
//  NewsViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/31/25.
//


import Foundation
import XSwiftUI
import EasyX
import EasyXConnect
final class NewsViewModelBindings:IBindings{
    func getDependency() -> NewsViewModel {
        if let viewModel = try? DIContainer.shared.resolve(NewsViewModel.self){
            return viewModel
        }
        
        let viewModel = NewsViewModel(repositoy: NewsRepositoryBindings().getDependency())
        
        DIContainer.shared.register(NewsViewModel.self, factory: { _ in viewModel})
        
        return viewModel
        
    }
  
    func getDependencyForHome() -> NewsViewModel {
        if let viewModel = try? DIContainer.shared.resolve(NewsViewModel.self, name: "Home"){
            return viewModel
        }
        
        let viewModel = NewsViewModel(repositoy: NewsRepositoryBindings().getDependency())
        
        DIContainer.shared.register(NewsViewModel.self,name: "Home", factory: { _ in viewModel})
        
        return viewModel
        
    }
    
    
    func getDependencyForLeague(leagueId: Int) -> NewsViewModel {
        if let viewModel = try? DIContainer.shared.resolve(NewsViewModel.self, name: "leagueId_\(leagueId)"){
            return viewModel
        }
        
        let viewModel = NewsViewModel(repositoy: NewsRepositoryBindings().getDependency(), leagueID: leagueId)
        
        DIContainer.shared.register(NewsViewModel.self,name: "leagueId_\(leagueId)", factory: { _ in viewModel})
        
        return viewModel
        
    }
    
    
    typealias T = NewsViewModel
}


final class NewsViewModel: ObservableObject {
    
    private let repositoy: INewsRepository
    
 
    init(repositoy: INewsRepository) {
        self.repositoy = repositoy
        
        Task{
          await  getRecentNews()
        }
        Task{
          await  getTrendingNews()
        }
        Task{
            await getCategory()
        }
    }
    
    init(repositoy: INewsRepository, leagueID:Int) {
        self.repositoy = repositoy
        
        Task{
          await  getRecentNews(leagueId: leagueID)
        }
        Task{
          await  getTrendingNews(leagueId: leagueID)
        }
        Task{
            await getCategory()
        }
    }
    
    @Published var allCategory:[NewsCategoryModel] = []
    @Published var recentNewsList:[NewsDoc] = []
    @Published var trendingNewsList:[NewsDoc] = []
    
    @MainActor
    func getRecentNews(leagueId: Int? = nil) async{
        
        do{
           
            let res  =  try await repositoy.getAllNews(type: .recent, leagueId: leagueId, page: 1)
            recentNewsList = res.list
        }
        catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
    
    @MainActor
    func getTrendingNews(leagueId: Int? = nil) async{
        
        do{
            if trangingPage > trangingTotalPage  && trangingTotalPage != 1{
                return
            }
           
            let res =  try await repositoy.getAllNews(type: .trending, leagueId: leagueId, page: trangingPage)
            
            
            var combinedList = trendingNewsList
            for news in res.list {
                if !combinedList.contains(news) {
                    combinedList.append(news)
                }
            }
            trendingNewsList = combinedList
            
            
            trangingPage = res.nextPage
            trangingTotalPage = res.totalPages
        }
        catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
    
    
    @Published var trangingPage : Int = 1
    @Published var trangingTotalPage : Int = 1
    
    @MainActor
    func loadMoreTrendingNews(leagueId: Int? = nil)async{
        await  getTrendingNews(leagueId: leagueId)
    }
    @MainActor
    func getCategory()async{
        do{
           
            allCategory =  try await repositoy.getAllNewsCategory()
            allCategory = [.all ] + allCategory
        }
        catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
    
   
}
