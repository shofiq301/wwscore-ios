//
//  LineUpViewModelBindings.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/18/25.
//



import Foundation


import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI
import EasyX

final class LineUpViewModelBindings:IBindings{
    
    let fixtureId:Int
    
    
    init(fixtureId: Int) {
        self.fixtureId = fixtureId
    }
    
    func getDependency()-> LineUpViewModel{
        
        do{
            let viewMOdel = try?  SmartDI.DI.resolve(LineUpViewModel.self , name: "\(fixtureId)", scope: nil)
            
            if let viewMode = viewMOdel{
                return viewMode
            }else{
                
                let repository =  LineUpRepositoryBindings().getDependency()
                
                let viewModel =   LineUpViewModel(fixtureId: fixtureId, repository: repository)
                
                SmartDI.DI.register(LineUpViewModel.self, name: "\(fixtureId)") { r in
                    viewModel
                }
                return viewModel
            }
        }
    }
    
}


final class LineUpViewModel:ObservableObject{
    
    let fixtureId:Int
    
    private let repository: ILineUPRepository
    
    @Published var teamsList:[LineUpsData] = []
    @Published var loading: Bool = false
    
    init(fixtureId: Int, repository: ILineUPRepository ) {
        self.fixtureId = fixtureId
        self.repository = repository
        Task{
           await getLineUps()
        }
    }
    
    @MainActor
    func getLineUps()async{
        do {
            loading = true
            let teams:[LineUpsData] =   try await repository.getLineUps(fixtureId: fixtureId)
            teamsList = teams
        }
        catch{
            
            print("error is \(error)")
        }
        loading = false
    }
    
    
    func getLineUpBuTeam(teamId: Int)-> LineUpsData?{
        
      return teamsList.first { data in
            data.team.id == teamId
        }
        
        
    }
    
}
