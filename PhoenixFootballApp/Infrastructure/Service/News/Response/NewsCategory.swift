//
//  NewsCategory.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/29/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsCategory = try? JSONDecoder().decode(NewsCategory.self, from: jsonData)

import Foundation

// MARK: - NewsCategory
struct NewsCategoryResponse: Codable , Sendable{
    let status: Bool
    let message: String
    let data: [NewsCategoryModel]
}

// MARK: - Datum
struct NewsCategoryModel: Codable, Sendable , Identifiable,Hashable {
    let id: String
    let datumID: Int?
    let name: String?
    let type: String?
    let logo: String?
    let createdAt, updatedAt: String?
    
    init(id: String, datumID: Int?, name: String?, type: String?, logo: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.datumID = datumID
        self.name = name
        self.type = type
        self.logo = logo
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case datumID = "id"
        case name, type, logo, createdAt, updatedAt
    }
}
extension NewsCategoryModel{
    static  let all = NewsCategoryModel(id: "All", datumID: -1, name: "All", type: nil, logo: nil, createdAt: nil, updatedAt: nil)
}
