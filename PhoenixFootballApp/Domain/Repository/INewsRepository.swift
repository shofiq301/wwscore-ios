//
//  INewsRepository.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/31/25.
//

import Foundation
import EasyXConnect
import EasyX
import XSwiftUI
import APIFootball

enum NewsType:String, Sendable{
    case recent = "recent"
    case trending = "trending"
}

protocol INewsRepository:Actor{
    func getAllNews(type: NewsType? , leagueId:Int? ,page:Int   )async throws -> PaginationModel<NewsDoc>
    func getAllNewsCategory()async throws -> [NewsCategoryModel]
}
