//
//  FixtureRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect

extension Date{
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
public protocol IFixtureRepository:Actor{
    
    func getMatchFixtureByDate( date:Date) async throws -> PaginationModel<FixtureDataResponse>
    func getMatchFixtureByLeagueID( league:Int, season:Int) async throws -> PaginationModel<FixtureDataResponse>
    func getMatchFixtureByID( id:Int) async throws -> PaginationModel<FixtureDataResponse>
    func getOnGoingMatchs( ) async throws -> PaginationModel<FixtureDataResponse>
    func getHeadToHeadMatchs(homeTeam: Int, awayTeam: Int) async throws -> PaginationModel<FixtureDataResponse>
    
    func getMatchFixtureByteamID( id:Int, season:Int) async throws -> PaginationModel<FixtureDataResponse>
    func getLastXMatchFixtureByteamID( id:Int,  last:Int) async throws -> PaginationModel<FixtureDataResponse>
    func getNextNMatchFixtureByteamID( id:Int,  next:Int) async throws -> PaginationModel<FixtureDataResponse>
}


actor FixtureRepository:IFixtureRepository{
   
    
  
    
    
    private let client: ExHttpConnect
    
    init(client: ExHttpConnect){
        self.client = client
    }
    
    
    
    
    func getMatchFixtureByDate(date:Date) async throws ->  PaginationModel<FixtureDataResponse> {
        
        
        var matchList: [FixtureDataResponse] = []
        
        do {
            //["date":"2023-07-07"]
            let d = date.string(withFormat: "yyyy-MM-dd")
            //let d = "2023-08-10"
            //  print(d)
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures", headers: [:], query: ["date": d] )
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
            
            
        }
    }
    
    func getMatchFixtureByID(id: Int) async throws -> PaginationModel<FixtureDataResponse> {
        var matchList: [FixtureDataResponse] = []
        
        do {
            //["date":"2023-07-07"]
            //let d = date.string(withFormat: "yyyy-MM-dd")
            
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures", headers: [:], query: ["id": "\(id)"] )
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
            
            
        }
    }
    
    
    func getOnGoingMatchs() async throws -> PaginationModel<FixtureDataResponse> {
        var matchList: [FixtureDataResponse] = []
        
        do {
            
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures", headers: [:], query: ["live": "all"] )
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
            
            
        }
    }
    
    
    func getHeadToHeadMatchs(homeTeam: Int, awayTeam: Int) async throws -> PaginationModel<FixtureDataResponse> {
        var matchList: [FixtureDataResponse] = []
        
        do {
            
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures/headtohead", headers: [:], query: ["h2h": "\(homeTeam)-\(awayTeam)"] )
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
            
            
        }
    }
    
    func getMatchFixtureByLeagueID(league: Int, season: Int) async throws -> PaginationModel<FixtureDataResponse> {
        var matchList: [FixtureDataResponse] = []
        
        do {
            
            let query = [
                
                "league":"\(league)",
                "season":"\(season)"
            ]
            
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures", headers: [:], query: query)
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
        }
    }
    
    
    func getMatchFixtureByteamID(id: Int,  season:Int) async throws -> PaginationModel<FixtureDataResponse> {
        var matchList: [FixtureDataResponse] = []
        
        do {
            //["date":"2023-07-07"]
            //let d = date.string(withFormat: "yyyy-MM-dd")
            
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures", headers: [:], query: ["team": "\(id)" ,"season": "\(season)" ] )
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
            
            
        }
    }
    
    func getLastXMatchFixtureByteamID(id: Int,  last: Int) async throws -> PaginationModel<FixtureDataResponse> {
        var matchList: [FixtureDataResponse] = []
        
        do {
            //["date":"2023-07-07"]
            //let d = date.string(withFormat: "yyyy-MM-dd")
            
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures", headers: [:], query: ["team": "\(id)"  , "last": "\(last)"] )
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
            
            
        }
    }
    
   
    
    func getNextNMatchFixtureByteamID(id: Int, next: Int) async throws -> PaginationModel<FixtureDataResponse> {
        do{
            
            var matchList: [FixtureDataResponse] = []
            
            let res: AppResponse<GenericNetworkModel<FixtureResponse>> =  try await client.get("fixtures", headers: [:], query: ["team": "\(id)"  , "next": "\(next)"] )
            
            
            if let mList = res.payload?.data?.response {
                matchList = mList
            }
            
            var page: Int = 0
            var totalPages: Int = 0
            
            if let p = res.payload?.data?.paging{
                page = p.current
                totalPages = p.total
            }
            
            return PaginationModel(page: page, totalPages:totalPages, list: matchList)
        }
    }
    
}
