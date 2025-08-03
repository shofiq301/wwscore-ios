//
//  AppSettingsRepository.swift
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


final class AppSettingsRepositoryBindings:IBindings{
    func getDependency() -> AppSettingsRepository {
       return AppSettingsRepository(client: try! HTTPClient.getClient(name: DIRegisteredKeys.adminUrl.rawValue))
    }
}

actor AppSettingsRepository{
    private let client: ExHttpConnect

    init(client: ExHttpConnect) {
      self.client = client
    }
    
    
    func getSettings() async throws -> AppSettingDataClass {
        do{
            let response: AppResponse<AppSettingResponse> = try await client.get("user/settings/get", query: nil)
            
            if let payload = response.payload?.data{
                return payload
            }
         
            throw NotFoundException(message: response.payload?.message ?? "something went wrong")
        }
    }
}
