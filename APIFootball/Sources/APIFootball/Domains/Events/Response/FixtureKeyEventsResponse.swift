// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fixtureKeyEventsResponse = try? JSONDecoder().decode(FixtureKeyEventsResponse.self, from: jsonData)

import Foundation

// MARK: - FixtureKeyEventsResponse
struct FixtureKeyEventsResponse: Codable, Sendable {
  
    let response: [FixtureKeyEventsData]

    enum CodingKeys: String, CodingKey {
       
        case response = "response"
    }
}


// MARK: - Response
public struct FixtureKeyEventsData: Codable, Sendable  {
    public  let time: Time
    public let team: Team
    public let player: Assist
    public let assist: Assist
    public  let type: String
    public let detail: String
    public let comments: String?

    enum CodingKeys: String, CodingKey {
        case time = "time"
        case team = "team"
        case player = "player"
        case assist = "assist"
        case type = "type"
        case detail = "detail"
        case comments = "comments"
    }
}

// MARK: - Assist
public struct Assist: Codable, Sendable  {
    public let id: Int?
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}


// MARK: - Time
public struct Time: Codable, Sendable  {
    public  let elapsed: Elapsed
    public  let extra: Elapsed?
}

public  enum Elapsed: Codable, Sendable  {
    case integer(Int)
    case string(String)
    
    public  init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Elapsed.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Elapsed"))
    }
    
    public   func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    
   public func getTime()->Int{
        
        switch self{
        case .integer(let t):
            return t
        case .string(let v):
            return Int(v) ?? 0
        }
    }
}
