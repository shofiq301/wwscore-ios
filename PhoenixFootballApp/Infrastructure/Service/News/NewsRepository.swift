//
//  NewsRepository.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/31/25.
//

import EasyXConnect
import Foundation
import APIFootball

actor NewsRepository: INewsRepository {


  private let client: ExHttpConnect

  init(client: ExHttpConnect) {
    self.client = client
  }

    func getAllNews(type: NewsType? , leagueId:Int?, page:Int = 1) async throws -> PaginationModel<NewsDoc> {

    do {

        var queryParams: [String: String] = [:]
        queryParams["page"] = page.description
        if let type = type {
            queryParams["type"] = type.rawValue
        }
        if let leagueId = leagueId {
            queryParams["leagueId"] = String(leagueId)
        }
        
      let response: AppResponse<NewsResponse> = try await client.get("user/news/all", query: queryParams)

      if let payload = response.payload?.data?.docs {
          let totalPages = response.payload?.data?.totalPage ?? 1
        return PaginationModel(page: page, totalPages: totalPages, list: payload)
      }
    }

    throw NotFoundException()
  }

  func getAllNewsCategory() async throws -> [NewsCategoryModel] {
    do {

      let response: AppResponse<NewsCategoryResponse> = try await client.get("user/news/categories")

      if let payload = response.payload?.data {
        return payload
      }
    }

    throw NotFoundException()
  }

}
