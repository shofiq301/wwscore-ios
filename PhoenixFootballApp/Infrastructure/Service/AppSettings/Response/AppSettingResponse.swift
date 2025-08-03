//
//  AppSettingResponse.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/28/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let appSettingResponse = try? JSONDecoder().decode(AppSettingResponse.self, from: jsonData)

import Foundation

// MARK: - AppSettingResponse
struct AppSettingResponse: Codable, Sendable {
    let status: Bool
    let message: String
    let data: AppSettingDataClass
}

// MARK: - DataClass
struct AppSettingDataClass: Codable, Sendable {
    let id: String
    let v: Int
    let aboutUs: String
    let android: Android
    let banner: Banner
    let createdAt: String
    let iOS: Android
    let privacyPolicy, termAndCondition, updatedAt: String
    let button: Bool
    let buttonName: String
    let topLeagues: [TopLeague]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case aboutUs, android, banner, createdAt, iOS, privacyPolicy, termAndCondition, updatedAt, button, buttonName, topLeagues
    }
}

// MARK: - Android
struct Android: Codable, Sendable {
    let version: Int
    let update: Bool
    let appURL, button, id: String

    enum CodingKeys: String, CodingKey {
        case version, update
        case appURL = "appUrl"
        case button
        case id = "_id"
    }
}

// MARK: - Banner
struct Banner: Codable, Sendable {
    let status: Bool
    let id: String

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
    }
}

// MARK: - TopLeague
struct TopLeague: Codable, Sendable {
    let id: String
    let topLeagueID: Int
    let name: String
    let type: String
    let logo: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case topLeagueID = "id"
        case name, type, logo, createdAt, updatedAt
    }
}
