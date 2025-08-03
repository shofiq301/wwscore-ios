//
//  MatchDetailsViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/17/25.
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

final class MatchDetailsViewModelBindings:IBindings{
    let matchId:Int
    
    init(matchId: Int) {
        self.matchId = matchId
    }
    
    func getDependency()->MatchDetailsViewModel{
        do{
            let viewModel = try? SmartDI.DI.resolve(MatchDetailsViewModel.self, name: "\(matchId)", scope: nil)
            
            
            if let viewModel = viewModel{
                return viewModel
            }else{
                
                let stRepository = StandingsRepositoryBindings().getDependency()
                let repository = LeaguesRepositoryBindings().getDependency()
                let fitureRepo =  FixtureRepositoryBindings().getDependency()
                let topPermersRepository = TopPerformersRepositoryBindings().getDependency()
                let viewModel = MatchDetailsViewModel(
                    matchId: matchId,
                    fixtureRepository: fitureRepo,
                    standingRepository: stRepository
                )
                
                SmartDI.DI.register(MatchDetailsViewModel.self, name: "\(matchId)") { r in
                    viewModel
                }
                
                return viewModel
            }
        }
    }
}


final class MatchDetailsViewModel:ObservableObject{
    let matchId:Int
    private let fixtureRepository: IFixtureRepository
    private let standingRepository: IStandingRepository
    
    init(matchId: Int, fixtureRepository: IFixtureRepository, standingRepository: IStandingRepository) {
        self.matchId = matchId
        self.fixtureRepository = fixtureRepository
        self.standingRepository = standingRepository
    }
    
    
    @Published var standingsList: [Standing] = []
    
    @MainActor
     func getSTandings(leagueId: Int, currentSeason: Int)async{
        
        do{
            
            let list =   try await   standingRepository.getStandingByLeagueAndSeason(league: leagueId, season: currentSeason)
            
            standingsList = list
            
        }
        catch{
            print("error is \(error)")
        }
        
        
    }
}
