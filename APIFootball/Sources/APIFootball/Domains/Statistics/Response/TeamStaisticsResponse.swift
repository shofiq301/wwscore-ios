// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamStatistics = try? JSONDecoder().decode(TeamStatistics.self, from: jsonData)

import Foundation

// MARK: - TeamStatistics
struct TeamStaisticsResponse: Codable, Sendable {

    let response: [StatisticsResponse]

    enum CodingKeys: String, CodingKey {
    
        case response = "response"
    }
}


// MARK: - Response
public struct StatisticsResponse: Codable, Sendable {
    public let team: Team
    public let statistics: [Statistic]

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case statistics = "statistics"
    }
}

// MARK: - Statistic
public struct Statistic: Codable, Sendable {
    public let type: String
    public let value: StatisticValue

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case value = "value"
    }
}

public enum StatisticValue: Codable, CustomStringConvertible, Sendable {
    case integer(Int)
    case string(String)
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(StatisticValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
    
    public var description: String {
            switch self {
            case .integer(let intValue):
                return String(intValue)
            case .string(let stringValue):
                return stringValue
            case .null:
                return "0"
            }
        }

}


func getDummyTeamStatistics()-> TeamStaisticsResponse{
    
    let jsonString = """
{
    "get": "fixtures/statistics",
    "parameters": {
        "fixture": "215662"
    },
    "errors": [],
    "results": 2,
    "paging": {
        "current": 1,
        "total": 1
    },
    "response": [
        {
            "team": {
                "id": 463,
                "name": "Aldosivi",
                "logo": "https://media-2.api-sports.io/football/teams/463.png"
            },
            "statistics": [
                {
                    "type": "Shots on Goal",
                    "value": 3
                },
                {
                    "type": "Shots off Goal",
                    "value": 2
                },
                {
                    "type": "Total Shots",
                    "value": 9
                },
                {
                    "type": "Blocked Shots",
                    "value": 4
                },
                {
                    "type": "Shots insidebox",
                    "value": 4
                },
                {
                    "type": "Shots outsidebox",
                    "value": 5
                },
                {
                    "type": "Fouls",
                    "value": 22
                },
                {
                    "type": "Corner Kicks",
                    "value": 3
                },
                {
                    "type": "Offsides",
                    "value": 1
                },
                {
                    "type": "Ball Possession",
                    "value": "32%"
                },
                {
                    "type": "Yellow Cards",
                    "value": 5
                },
                {
                    "type": "Red Cards",
                    "value": 1
                },
                {
                    "type": "Goalkeeper Saves",
                    "value": null
                },
                {
                    "type": "Total passes",
                    "value": 242
                },
                {
                    "type": "Passes accurate",
                    "value": 121
                },
                {
                    "type": "Passes %",
                    "value": "50%"
                }
            ]
        },
        {
            "team": {
                "id": 442,
                "name": "Defensa Y Justicia",
                "logo": "https://media-1.api-sports.io/football/teams/442.png"
            },
            "statistics": [
                {
                    "type": "Shots on Goal",
                    "value": null
                },
                {
                    "type": "Shots off Goal",
                    "value": 3
                },
                {
                    "type": "Total Shots",
                    "value": 7
                },
                {
                    "type": "Blocked Shots",
                    "value": 4
                },
                {
                    "type": "Shots insidebox",
                    "value": 4
                },
                {
                    "type": "Shots outsidebox",
                    "value": 3
                },
                {
                    "type": "Fouls",
                    "value": 10
                },
                {
                    "type": "Corner Kicks",
                    "value": 5
                },
                {
                    "type": "Offsides",
                    "value": 9
                },
                {
                    "type": "Ball Possession",
                    "value": "68%"
                },
                {
                    "type": "Yellow Cards",
                    "value": 5
                },
                {
                    "type": "Red Cards",
                    "value": null
                },
                {
                    "type": "Goalkeeper Saves",
                    "value": 2
                },
                {
                    "type": "Total passes",
                    "value": 514
                },
                {
                    "type": "Passes accurate",
                    "value": 397
                },
                {
                    "type": "Passes %",
                    "value": "77%"
                }
            ]
        }
    ]
}
"""
    
    
    do{
        
        let data: TeamStaisticsResponse? = try?   jsonString.toObject()
        
        
        return data!
    }
    
    
    
}
