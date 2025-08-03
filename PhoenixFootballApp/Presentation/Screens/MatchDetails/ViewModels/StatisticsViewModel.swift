//
//  StatisticsViewModelbindings.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/24/25.
//



import Foundation

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

@MainActor
final class StatisticsViewModelbindings{
    
    let fixture:Int
    
    
    init(fixture: Int) {
        self.fixture = fixture
    }
    
    
    func getDependices()-> StatisticsViewModel{
        
        do{
            let viewModel:StatisticsViewModel? = try? SmartDI.DI.resolve(StatisticsViewModel.self, name: "\(fixture)", scope: nil)
            
            if let viewModel = viewModel {
                return viewModel
            }else{
                
                let repository: IStatisticsRepository = StatisticsRepositoryBindings().getDependency()
                
                let viewModel = StatisticsViewModel(repository: repository, fixture: fixture)
                
                SmartDI.DI.register(StatisticsViewModel.self, name: "\(fixture)") { r in
                    viewModel
                }
                
                return viewModel
            }
        }
    }
}


final class StatisticsViewModel:ObservableObject{
    
    
    let repository: IStatisticsRepository
    
    
    let fixture:Int
    
    
    init(repository: IStatisticsRepository, fixture: Int) {
        self.repository = repository
        self.fixture = fixture
        
        Task{
            
            await getStatistics()
        }
    }
    
     
    @Published var staticsList:[StatisticsResponse] = []
    @Published var loading: Bool = false
    
    @MainActor
    func getStatistics()async{
        
        do{
            loading = true
            let list:[StatisticsResponse] =  try await repository.getStatics(fixture: fixture)
            
            
            staticsList = list
            
            
        }catch{
            print("error is \(error)")
        }
        loading = false
    }
    
    func getTeamSTate(teamId:Int, key:String)-> StatisticValue{
        let data =   staticsList.first { d in
            d.team.id == teamId
        }
        
        if let data = data{
        
          let v =  data.statistics.first(where: {$0.type == key})
            
            if let value = v?.value{
//                return "\(value)"
                return value
            }
            
        }
        
        
        return .integer(0)
    }
    
}
