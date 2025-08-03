//
//  FixtureLineUpResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fixtureLineUPResponse = try? JSONDecoder().decode(FixtureLineUPResponse.self, from: jsonData)

import Foundation

extension Int{
    func toString()-> String {
        return "\(self)"
    }
}

// MARK: - FixtureLineUPResponse
struct FixtureLineUPResponse: Codable, Sendable {
    
    let response: [LineUpsData]
    
    enum CodingKeys: String, CodingKey {
        
        case  response
    }
}

// MARK: - Response
public struct LineUpsData: Codable, Sendable {
    public let team: Team
    public let coach: Coach
    public let formation: String?
    public let startXI, substitutes: [StartXi]
    
    public func getSortedStartXI()->[StartXi]{
        var list = startXI
        list =  list.sorted { a, b in
            (a.player.grid ?? "" ) < (b.player.grid ?? "")
        }
        return list
    }
    
    public func getFormationList() ->[Int]{
        
        var list:[Int]=[]
        
        
        if let formationString = formation{
            
            let formationIntArray = formationString.components(separatedBy: "-").compactMap { Int($0) }

            list = formationIntArray
        }
        
        
        
        return list
        
    }
}

// MARK: - Coach
public struct Coach: Codable, Sendable {
    public let id: Int?
    public let name: String?
    public let photo: String?
}

// MARK: - StartXi
public struct StartXi: Codable, Sendable {
    
    public let player: Player
    
}

// MARK: - Player
public struct Player: Codable, Sendable {
    public let id: Int
    public let name: String
    public let number: Int?
    public let pos: Pos?
    public let grid: String?
}

public enum Pos: String, Codable, Sendable {
    case d = "D"
    case f = "F"
    case g = "G"
    case m = "M"
    
    func toString()-> String{
        
        switch self{
        case .d:
            return "Defender"
        case .f:
            return "Forward"
        case .g:
            return "Goalkeeper"
        case .m:
            return "Midfielder"
        }
        
    }
}

// MARK: - Team
public struct Team: Codable, Sendable {
    public let id: Int
    public let name: String
    public let logo: String
    //  let colors: JSONNull?
}

func getDummyFixtureLineUPResponse()-> FixtureLineUPResponse{
    
    
    let jsonStr = """
{
    "get": "fixtures/lineups",
    "parameters": {
        "fixture": "983785"
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
                "id": 2329,
                "name": "A. Italiano",
                "logo": "https://media-2.api-sports.io/football/teams/2329.png",
                "colors": {
                    "player": {
                        "primary": "2f7b54",
                        "number": "ffffff",
                        "border": "2f7b54"
                    },
                    "goalkeeper": {
                        "primary": "148814",
                        "number": "ffffff",
                        "border": "148814"
                    }
                }
            },
            "coach": {
                "id": 13999,
                "name": "L. Marcogiuseppe",
                "photo": "https://media-1.api-sports.io/football/coachs/13999.png"
            },
            "formation": "4-4-2",
            "startXI": [
                {
                    "player": {
                        "id": 11495,
                        "name": "T. Ahumada",
                        "number": 12,
                        "pos": "G",
                        "grid": "1:1"
                    }
                },
                {
                    "player": {
                        "id": 11518,
                        "name": "O. Rojas",
                        "number": 16,
                        "pos": "D",
                        "grid": "2:4"
                    }
                },
                {
                    "player": {
                        "id": 11501,
                        "name": "C. Labrín",
                        "number": 2,
                        "pos": "D",
                        "grid": "2:3"
                    }
                },
                {
                    "player": {
                        "id": 11504,
                        "name": "O. Bosso",
                        "number": 4,
                        "pos": "D",
                        "grid": "2:2"
                    }
                },
                {
                    "player": {
                        "id": 353975,
                        "name": "E. Matus",
                        "number": 17,
                        "pos": "D",
                        "grid": "2:1"
                    }
                },
                {
                    "player": {
                        "id": 6238,
                        "name": "F. Juárez",
                        "number": 15,
                        "pos": "M",
                        "grid": "3:3"
                    }
                },
                {
                    "player": {
                        "id": 5914,
                        "name": "M. Díaz",
                        "number": 21,
                        "pos": "M",
                        "grid": "3:2"
                    }
                },
                {
                    "player": {
                        "id": 36475,
                        "name": "G. Hachen",
                        "number": 32,
                        "pos": "M",
                        "grid": "3:1"
                    }
                },
                {
                    "player": {
                        "id": 11500,
                        "name": "N. Fernández",
                        "number": 7,
                        "pos": "F",
                        "grid": "4:3"
                    }
                },
                {
                    "player": {
                        "id": 12297,
                        "name": "G. Sosa",
                        "number": 9,
                        "pos": "F",
                        "grid": "4:2"
                    }
                },
                {
                    "player": {
                        "id": 194899,
                        "name": "G. Ríos",
                        "number": 19,
                        "pos": "F",
                        "grid": "4:1"
                    }
                }
            ],
            "substitutes": [
                {
                    "player": {
                        "id": 11713,
                        "name": "M. Fuentes",
                        "number": 10,
                        "pos": "F",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 11486,
                        "name": "M. Sepúlveda",
                        "number": 8,
                        "pos": "M",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 11749,
                        "name": "L. Riveros",
                        "number": 11,
                        "pos": "F",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 11767,
                        "name": "M. Collao",
                        "number": 18,
                        "pos": "M",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 408960,
                        "name": "D. Monreal",
                        "number": 27,
                        "pos": "D",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 11496,
                        "name": "J. García",
                        "number": 13,
                        "pos": "G",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 11472,
                        "name": "R. Cereceda",
                        "number": 28,
                        "pos": "D",
                        "grid": null
                    }
                }
            ]
        },
        {
            "team": {
                "id": 2318,
                "name": "Palestino",
                "logo": "https://media-1.api-sports.io/football/teams/2318.png",
                "colors": {
                    "player": {
                        "primary": "fefcfc",
                        "number": "2b0f0f",
                        "border": "fefcfc"
                    },
                    "goalkeeper": {
                        "primary": "ff9999",
                        "number": "000000",
                        "border": "ff9999"
                    }
                }
            },
            "coach": {
                "id": 3973,
                "name": "P. Sánchez",
                "photo": "https://media-3.api-sports.io/football/coachs/3973.png"
            },
            "formation": "4-4-2",
            "startXI": [
                {
                    "player": {
                        "id": 6564,
                        "name": "C. Rigamonti",
                        "number": 1,
                        "pos": "G",
                        "grid": "1:1"
                    }
                },
                {
                    "player": {
                        "id": 35487,
                        "name": "D. Zúñiga",
                        "number": 28,
                        "pos": "D",
                        "grid": "2:4"
                    }
                },
                {
                    "player": {
                        "id": 311315,
                        "name": "A. Ceza",
                        "number": 4,
                        "pos": "D",
                        "grid": "2:3"
                    }
                },
                {
                    "player": {
                        "id": 11635,
                        "name": "C. Suárez",
                        "number": 13,
                        "pos": "D",
                        "grid": "2:2"
                    }
                },
                {
                    "player": {
                        "id": 11614,
                        "name": "B. Véjar",
                        "number": 19,
                        "pos": "D",
                        "grid": "2:1"
                    }
                },
                {
                    "player": {
                        "id": 35997,
                        "name": "B. Carrasco",
                        "number": 7,
                        "pos": "M",
                        "grid": "3:4"
                    }
                },
                {
                    "player": {
                        "id": 11461,
                        "name": "M. Dávila",
                        "number": 10,
                        "pos": "M",
                        "grid": "3:3"
                    }
                },
                {
                    "player": {
                        "id": 11604,
                        "name": "A. Farías",
                        "number": 5,
                        "pos": "M",
                        "grid": "3:2"
                    }
                },
                {
                    "player": {
                        "id": 11536,
                        "name": "J. Benítez",
                        "number": 11,
                        "pos": "M",
                        "grid": "3:1"
                    }
                },
                {
                    "player": {
                        "id": 196005,
                        "name": "B. Barticciotto",
                        "number": 14,
                        "pos": "F",
                        "grid": "4:2"
                    }
                },
                {
                    "player": {
                        "id": 11493,
                        "name": "M. Salas",
                        "number": 9,
                        "pos": "F",
                        "grid": "4:1"
                    }
                }
            ],
            "substitutes": [
                {
                    "player": {
                        "id": 36024,
                        "name": "J. Abrigo",
                        "number": 37,
                        "pos": "F",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 35616,
                        "name": "F. Meza",
                        "number": 2,
                        "pos": "D",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 197536,
                        "name": "B. Rojas",
                        "number": 3,
                        "pos": "D",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 275535,
                        "name": "N. Meza",
                        "number": 6,
                        "pos": "M",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 11817,
                        "name": "G. Collao",
                        "number": 18,
                        "pos": "G",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 274563,
                        "name": "F. Chamorro",
                        "number": 22,
                        "pos": "M",
                        "grid": null
                    }
                },
                {
                    "player": {
                        "id": 372148,
                        "name": "D. Salgado",
                        "number": 25,
                        "pos": "F",
                        "grid": null
                    }
                }
            ]
        }
    ]
}
"""
    do{
        
        let data: FixtureLineUPResponse? =   try? jsonStr.toObject()
        
        // print(data)
        return data!
    }
    
    
}
