//
//  FixtureResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation

// MARK: - FixtureResponse
struct FixtureResponse: Codable, Sendable {

  let paging: Paging
  let response: [FixtureDataResponse]

  enum CodingKeys: String, CodingKey {

    case paging, response
  }
}

// MARK: - Paging
public struct Paging: Codable, Sendable {
    public  let current, total: Int
}

// MARK: - Response
public struct FixtureDataResponse: Codable, Hashable, Equatable, Sendable, Identifiable {
    public  var id: Int {
        fixture.id
    }
    public  let fixture: Fixture
    public let league: League
    public let teams: Teams
    public  let goals: Goals
    public let score: Score
    public let urls: [URLElement]?

    public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.fixture = try container.decode(Fixture.self, forKey: .fixture)
    self.league = try container.decode(League.self, forKey: .league)
    self.teams = try container.decode(Teams.self, forKey: .teams)
    self.goals = try container.decode(Goals.self, forKey: .goals)
    self.score = try container.decode(Score.self, forKey: .score)
    self.urls = try container.decodeIfPresent([URLElement].self, forKey: .urls)

  }

    public static func == (lhs: FixtureDataResponse, rhs: FixtureDataResponse) -> Bool {
    return lhs.fixture.id == rhs.fixture.id
  }

  // Implement the hash(into:) method
    public  func hash(into hasher: inout Hasher) {
    hasher.combine(fixture.id)
  }
}
public struct URLElement: Codable, Sendable {
    public  let label: String
    public  let url: String
}

// MARK: - Fixture
public struct Fixture: Codable, Sendable{
    public let id: Int
    public let referee: String?
    public let timezone: Timezone
    public let date: Date
    public let timestamp: Int
    public let periods: Periods
    public let venue: Venue
    public let status: Status
  enum CodingKeys: String, CodingKey {
    case id, referee, timezone, date, timestamp, periods, venue, status
  }

    public  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    referee = try container.decodeIfPresent(String.self, forKey: .referee)
    timezone = try container.decode(Timezone.self, forKey: .timezone)
    timestamp = try container.decode(Int.self, forKey: .timestamp)
    periods = try container.decode(Periods.self, forKey: .periods)
    venue = try container.decode(Venue.self, forKey: .venue)
    status = try container.decode(Status.self, forKey: .status)

    // Decode the date string to a Date object
    let dateString = try container.decode(String.self, forKey: .date)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"  // Adjust the date format as needed
//    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // Adjust the date format as needed
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        
    if let date = dateFormatter.date(from: dateString) {
      self.date = date
    }
   else  if let date = dateFormatter2.date(from: dateString) {
       self.date = date
     }
        else {
      throw DecodingError.dataCorruptedError(
        forKey: .date, in: container, debugDescription: "Invalid date format")
    }
  }

    public func getStartDate(dateFormat: String =  "dd.MM.yyyy") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat 
    return formatter.string(from: date)
  }

    public func timeRemaining() -> String {
    let calendar = Calendar.current
    let components = calendar.dateComponents(
      [.day, .hour, .minute, .second], from: Date(), to: date)

    if let days = components.day, days != 0 {

      return String(format: "%02d \( days > 1 ? "days": "day")", days)
    } else if let hours = components.hour, hours != 0 {
      return String(format: "%02d \(hours > 1 ? "hours":"hour")", hours)
    } else if let minutes = components.minute, minutes != 0 {
      return String(format: "%02d \(minutes > 1 ? "minutes" : "minute")", minutes)
    } else if let seconds = components.second {
      return String(format: "%02d \(seconds > 1 ? "seconds":"seconds" )", seconds)
    }

    return ""
  }

}

// MARK: - Periods
public struct Periods: Codable, Sendable {
    public  let first, second: Int?
}

// MARK: - Status
public struct Status: Codable, Sendable {
    public  let long: Long
    public   let short: Short
    public   let elapsed: Int?
}

public enum Long: String, Codable, Sendable {
  case matchCancelled = "Match Cancelled"
  case matchFinished = "Match Finished"
  case matchPostponed = "Match Postponed"
  case notStarted = "Not Started"
  case firstHalf = "First Half"
  case secondHalf = "Second Half"
  case halftime = "Halftime"
  case timeToBeDefined = "Time to be defined"
  case extraTime = "Extra Time"
  case KickOff = "Kick Off"
  case SecendHalfStarted = "2nd Half Started"
  case BreakTime = "Break Time"
  case PenaltyInProgress = "Penalty in progress"
  case MatchSuspended = "Match Suspended"
  case MatchInterrupted = "Match Interrupted"
  case MatchAbandoned = "Match Abandoned"
  case TechnicalLoss = "Technical Loss"
  case WalkOver = "WalkOver"
  case InProgress = "In Progress"
  case Technicalloss = "Technical loss"
}

public enum Short: String, Codable, Sendable {
  case TBD = "TBD"
  case NS = "NS"
  case FirstH = "1H"
  case HT = "HT"
  case SecondH = "2H"
  case ET = "ET"
  case BT = "BT"
  case P = "P"
  case SUSP = "SUSP"
  case INT = "INT"
  case FT = "FT"
  case AET = "AET"
  case PEN = "PEN"
  case PST = "PST"
  case CANC = "CANC"
  case ABD = "ABD"
  case AWD = "AWD"
  case WO = "WO"
  case LIVE = "LIVE"

    public  func isFinish() -> Bool {

    switch self {

    case .TBD, .NS, .FirstH, .HT, .SecondH, .ET, .BT, .P, .SUSP, .INT, .PST, .LIVE:
      return false
    case .FT, .AET, .PEN, .CANC, .ABD, .AWD, .WO:
      return true

    }

  }

    public func isInPlay() -> Bool {

    switch self {

    case .FirstH, .HT, .SecondH, .ET, .BT, .P, .SUSP, .INT, .LIVE:
      return true
    case .FT, .AET, .PEN, .CANC, .ABD, .AWD, .WO, .TBD, .NS, .PST:
      return false

    }
  }
    
   public func willStart() -> Bool {
        switch self {
        case  .NS:
            return true
        default:
            return false
        }
    }
}

public enum Timezone: String, Codable, Sendable {
  case utc = "UTC"
}

// MARK: - Venue
public struct Venue: Codable, Sendable {
    public let id: Int?
    public let name, city: String?
}

// MARK: - Goals
public struct Goals: Codable, Sendable {
    public let home, away: Int?
}

// MARK: - League
public struct League: Codable, Sendable {
    public let id: Int
    public let name, country: String
    public let logo: String
    public let flag: String?
    public let season: Int
    public let round: String?
}

// MARK: - Score
public struct Score: Codable, Sendable {
    public  let halftime, fulltime, extratime, penalty: Goals
}

// MARK: - Teams
public struct Teams: Codable, Sendable {
    public let home, away: Away

}

// MARK: - Away
public struct Away: Codable, Sendable {
    public  let id: Int
    public  let name: String
    public let logo: String
    public let winner: Bool?
}

func getdymmyFixtureDataResponseData() -> FixtureDataResponse {

  let st1 = """
        {

                    "fixture": {
                        "id": 983813,
                        "referee": "Juan Sepulveda,",
                        "timezone": "UTC",
                        "date": "2023-08-08T00:00:00+00:00",
                        "timestamp": 1691452800,
                        "periods": {
                            "first": 1691452800,
                            "second": 1691456400
                        },
                        "venue": {
                            "id": 342,
                            "name": "Estadio Santa Laura-Universidad SEK",
                            "city": "Santiago de Chile"
                        },
                        "status": {
                            "long": "Match Finished",
                            "short": "FT",
                            "elapsed": 90
                        }
                    },
                    "league": {
                        "id": 265,
                        "name": "Primera División",
                        "country": "Chile",
                        "logo": "https://media-1.api-sports.io/football/leagues/265.png",
                        "flag": "https://media-3.api-sports.io/flags/cl.svg",
                        "season": 2023,
                        "round": "Regular Season - 20"
                    },
                    "teams": {
                        "home": {
                            "id": 2323,
                            "name": "Universidad de Chile",
                            "logo": "https://media-3.api-sports.io/football/teams/2323.png",
                            "winner": false
                        },
                        "away": {
                            "id": 2320,
                            "name": "O'Higgins",
                            "logo": "https://media-2.api-sports.io/football/teams/2320.png",
                            "winner": true
                        }
                    },
                    "goals": {
                        "home": 2,
                        "away": 5
                    },
                    "score": {
                        "halftime": {
                            "home": 0,
                            "away": 0
                        },
                        "fulltime": {
                            "home": 2,
                            "away": 5
                        },
                        "extratime": {
                            "home": null,
                            "away": null
                        },
                        "penalty": {
                            "home": null,
                            "away": null
                        }
                    }
                }
    """

  let _ = """
    {
                "fixture": {
                    "id": 1104344,
                    "referee": null,
                    "timezone": "UTC",
                    "date": "2023-08-22T12:00:00+00:00",
                    "timestamp": 1692705600,
                    "periods": {
                        "first": null,
                        "second": null
                    },
                    "venue": {
                        "id": 19804,
                        "name": "Stadion Trud",
                        "city": "Miass"
                    },
                    "status": {
                        "long": "Not Started",
                        "short": "NS",
                        "elapsed": null
                    }
                },
                "league": {
                    "id": 237,
                    "name": "Cup",
                    "country": "Russia",
                    "logo": "https://media-2.api-sports.io/football/leagues/237.png",
                    "flag": "https://media-3.api-sports.io/flags/ru.svg",
                    "season": 2023,
                    "round": "Regions Path - 2nd Round"
                },
                "teams": {
                    "home": {
                        "id": 16864,
                        "name": "Torpedo Miass",
                        "logo": "https://media-3.api-sports.io/football/teams/16864.png",
                        "winner": null
                    },
                    "away": {
                        "id": 1076,
                        "name": "Amkar",
                        "logo": "https://media-2.api-sports.io/football/teams/1076.png",
                        "winner": null
                    }
                },
                "goals": {
                    "home": null,
                    "away": null
                },
                "score": {
                    "halftime": {
                        "home": null,
                        "away": null
                    },
                    "fulltime": {
                        "home": null,
                        "away": null
                    },
                    "extratime": {
                        "home": null,
                        "away": null
                    },
                    "penalty": {
                        "home": null,
                        "away": null
                    }
                }
            }
    """

  guard let jsonData = st1.data(using: .utf8) else {
    fatalError("Invalid JSON data")
  }
  do {
    let fixtureDataResponse = try? JSONDecoder().decode(FixtureDataResponse.self, from: jsonData)

    //       print(fixtureDataResponse)

    return fixtureDataResponse!

  }
  //    catch{
  //
  //        print("error is \(error)")
  //        let fixtureDataResponse = try? JSONDecoder().decode(FixtureDataResponse.self, from: jsonData)
  //        return fixtureDataResponse!
  //    }

}

extension String {

  func toObject<R: Codable>() throws -> R {

    guard let jsonData = self.data(using: .utf8) else {
      fatalError("Invalid JSON data")
    }
    do {
      let fixtureDataResponse = try JSONDecoder().decode(R.self, from: jsonData)

      return fixtureDataResponse
    }

  }
}

