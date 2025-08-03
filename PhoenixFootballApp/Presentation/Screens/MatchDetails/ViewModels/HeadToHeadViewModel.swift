//
//  HeadToHeadViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/24/25.
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

final class HeadToHeadViewModelBindings: IBindings{
    let homeTeam: Int
    let awayTeam: Int
    
    init(homeTeam: Int, awayTeam: Int) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
    
    func getDependency()->HeadToHeadViewModel{
        
        do{
            let viewModel = try? SmartDI.DI.resolve(HeadToHeadViewModel.self, name: "\(homeTeam)-\(awayTeam)", scope: nil)
            
            if let viewModel = viewModel {
              return  viewModel
            }else{
                
                let repository = FixtureRepositoryBindings().getDependency()
                let viewModel = HeadToHeadViewModel(repository: repository, homeTeam: homeTeam, awayTeam: awayTeam)
                SmartDI.DI.register(HeadToHeadViewModel.self , name: "\(homeTeam)-\(awayTeam)") { r in
                    viewModel
                }
                return viewModel
            }
            
        }
    }
    
    
    
}

final class HeadToHeadViewModel: ObservableObject{
    let repository: IFixtureRepository
    
    let homeTeam: Int
    let awayTeam: Int
    
    init(repository: IFixtureRepository, homeTeam: Int, awayTeam: Int) {
        self.repository = repository
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        
        Task{
            await getHeadToHead()
        }
    }
    
    
    @Published var h2hList:[FixtureDataResponse] = []
    @Published var homeTeamWin:Int = 0
    @Published var awayTeamWin:Int = 0
    @Published var totalDraw:Int = 0
    @Published var totalMatch:Int = 1
    @Published var progressValue: Float = 0.1
    
    @MainActor
    func getHeadToHead()async{
        
        
        do{
            
            let data: PaginationModel<FixtureDataResponse> = try await repository.getHeadToHeadMatchs(homeTeam: homeTeam, awayTeam: awayTeam)
            
            h2hList = data.list
            
            
            for d in data.list{
                
                if d.teams.home.winner == true{
                    
                    if d.teams.home.id == homeTeam{
                        homeTeamWin += 1
                    }else{
                        awayTeamWin += 1
                    }
                    
                    
                }else if d.teams.away.winner == true{
                    
                    if d.teams.away.id == homeTeam{
                        homeTeamWin += 1
                    }else{
                        awayTeamWin += 1
                    }
                    
                }
                
            }
            
            totalDraw = h2hList.count - (homeTeamWin + awayTeamWin)
            totalMatch =  h2hList.count
            progressValue = Float((Double(totalDraw) / Double(totalMatch)))
            
            
        }catch{
            print("error is => \(error)")
        }
        
    }
}
