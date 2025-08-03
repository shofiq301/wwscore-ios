//
//  NewsRepositoryBindings.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/31/25.
//

import Foundation
import EasyX
import XSwiftUI

final class NewsRepositoryBindings:IBindings{
    func getDependency() -> NewsRepository {
        return NewsRepository(client: try! HTTPClient.getClient(name: DIRegisteredKeys.adminUrl.rawValue))
    }
    
    typealias T = NewsRepository
    
}
final class LiveMatchRepositoryBindings:IBindings{
    func getDependency() -> LiveMatchRepository {
        return LiveMatchRepository(client: try! HTTPClient.getClient(name: DIRegisteredKeys.adminUrl.rawValue))
    }
    
    typealias T = LiveMatchRepository
    
}
