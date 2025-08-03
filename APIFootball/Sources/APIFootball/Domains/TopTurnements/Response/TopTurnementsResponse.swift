//
//  TopTurnementsResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation

// MARK: - TopTurnementsResponse
struct TopTurnementsResponse: Codable, Sendable {
 //   let status: Bool
    let data: [TurnementsData]

    enum CodingKeys: String, CodingKey {
       // case status = "status"
        case data = "data"
    }
}

// MARK: - Datum
public struct TurnementsData: Codable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let host: String
    public let type: String
    public let logo: String
 
    public let leagueID: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case host = "host"
        case type = "type"
        case logo = "logo"
        case leagueID = "league_id"
    }
    
    public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(leagueID)
        }

}


func getTopTurnamentsDummyData() -> TopTurnementsResponse{
    
    let jsonString = """
{
    "status": true,
    "data": [
        {
            "id": 3096,
            "name": "Ligue 1",
            "host": "France",
            "type": "League",
            "logo": "https://media-3.api-sports.io/football/leagues/61.png",
            "order": null,
            "league_id": 61
        },
        {
            "id": 3099,
            "name": "Premier League",
            "host": "England",
            "type": "League",
            "logo": "https://media-2.api-sports.io/football/leagues/39.png",
            "order": null,
            "league_id": 39
        },
        {
            "id": 3100,
            "name": "Bundesliga",
            "host": "Germany",
            "type": "League",
            "logo": "https://media-3.api-sports.io/football/leagues/78.png",
            "order": null,
            "league_id": 78
        },
        {
            "id": 3101,
            "name": "Serie A",
            "host": "Italy",
            "type": "League",
            "logo": "https://media-3.api-sports.io/football/leagues/135.png",
            "order": null,
            "league_id": 135
        },
        {
            "id": 3102,
            "name": "Eredivisie",
            "host": "Netherlands",
            "type": "League",
            "logo": "https://media-2.api-sports.io/football/leagues/88.png",
            "order": null,
            "league_id": 88
        },
        {
            "id": 3104,
            "name": "La Liga",
            "host": "Spain",
            "type": "League",
            "logo": "https://media-1.api-sports.io/football/leagues/140.png",
            "order": null,
            "league_id": 140
        },
        {
            "id": 3405,
            "name": "Pro League",
            "host": "Saudi-Arabia",
            "type": "League",
            "logo": "https://media-2.api-sports.io/football/leagues/307.png",
            "order": null,
            "league_id": 307
        },
        {
            "id": 3935,
            "name": "MLS All-Star",
            "host": "USA",
            "type": "Cup",
            "logo": "https://media-1.api-sports.io/football/leagues/866.png",
            "order": null,
            "league_id": 866
        },
        {
            "id": 3981,
            "name": "UEFA Europa Conference League",
            "host": "World",
            "type": "Cup",
            "logo": "https://media-3.api-sports.io/football/leagues/848.png",
            "order": null,
            "league_id": 848
        },
        {
            "id": 4122,
            "name": "Premier League",
            "host": "Bhutan",
            "type": "League",
            "logo": "https://media-3.api-sports.io/football/leagues/1031.png",
            "order": null,
            "league_id": 1031
        }
    ]
}
"""
    
    do{
        
        let data: TopTurnementsResponse? = try?   jsonString.toObject()
        
        
        return data!
    }
    
}
