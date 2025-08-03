//
//  LiveMatchResponse.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/27/25.
//
import Foundation
import APIFootball

struct LiveMatchResponse: Codable , Sendable{
    let status: Bool
    let message: String
    let data: [FixtureDataResponse]
}
