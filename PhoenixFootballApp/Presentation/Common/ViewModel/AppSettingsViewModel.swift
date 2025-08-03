//
//  AppSettingsViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/28/25.
//

import APIFootball
import EasyX
import EasyXConnect
import Foundation
import PhoenixUI
import XSwiftUI


final class AppSettingsViewModelBindings:IBindings{
    
    func getDependency() -> AppSettingsViewModel {
        if let viewModel = try? DIContainer.shared.resolve(AppSettingsViewModel.self, name: nil, scope: nil){
            return viewModel
        }
        
        let repository = AppSettingsRepositoryBindings().getDependency()
        let viewModel: AppSettingsViewModel = AppSettingsViewModel(repository: repository)
        
        
        DIContainer.shared.register(AppSettingsViewModel.self, name: nil, factory: { _ in  viewModel})
        
        return viewModel
    }
}

class AppSettingsViewModel: ObservableObject {

  private let repository: AppSettingsRepository

  init(repository: AppSettingsRepository) {
    self.repository = repository
  }

  @Published var settings: AppSettingDataClass? = nil
  @Published var topLeaguesID: [Int] = []

  @MainActor
  func getAppSettings() async {
    do {
      settings = try await repository.getSettings()
        
        topLeaguesID = settings?.topLeagues.compactMap(\.topLeagueID) ?? []
    } catch {
      AppLogger.log(PrettyErrorPrinter.prettyError(error))
    }

  }

}
