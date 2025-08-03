//
//  LiveMatchListViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/27/25.
//

import SwiftUI
import APIFootball
import EasyXConnect
import EasyX
import XSwiftUI


final class LiveMatchListViewModelBindings:IBindings{
    
    func getDependency() -> LiveMatchListViewModel {
        if let viewModel = try? DIContainer.shared.resolve(LiveMatchListViewModel.self){
            return viewModel
        }
        let viewModel = LiveMatchListViewModel(repository: LiveMatchRepositoryBindings().getDependency())
        
        DIContainer.shared.register(LiveMatchListViewModel.self) { _ in viewModel }
        return viewModel
    }
}

class LiveMatchListViewModel:ObservableObject{
    private let repository:LiveMatchRepository
    
    init(repository: LiveMatchRepository) {
        self.repository = repository
    }
    
    
    
    @Published var liveMatches:[FixtureDataResponse] = []
    
    
    @MainActor
    func getLiveMatches() async{
        do{
            liveMatches = try await repository.getALlLiveMatch()
        }catch{
            AppLogger.log(PrettyErrorPrinter.prettyError(error))
        }
    }
    
    
}
