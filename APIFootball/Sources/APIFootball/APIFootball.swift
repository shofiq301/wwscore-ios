// The Swift Programming Language
// https://docs.swift.org/swift-book
import EasyX
import EasyXConnect
import XSwiftUI

// MARK: - League Repository Bindings

/// Provides a concrete binding for `ILeaguesRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `LeaguesRepository` wired up with the shared HTTP client.
final public class LeaguesRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `ILeaguesRepository` implementation.
  ///
  /// - Returns: An instance of `LeaguesRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> ILeaguesRepository {
    return LeaguesRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Fixture Key Event Repository Bindings

/// Provides a concrete binding for `IFixtureKeyEventRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `FixtureKeyEventRepository` wired up with the shared HTTP client.
final public class FixtureKeyEventRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `IFixtureKeyEventRepository` implementation.
  ///
  /// - Returns: An instance of `FixtureKeyEventRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> IFixtureKeyEventRepository {
    return FixtureKeyEventRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Fixture Repository Bindings

/// Provides a concrete binding for `IFixtureRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `FixtureRepository` wired up with the shared HTTP client.
final public class FixtureRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `IFixtureRepository` implementation.
  ///
  /// - Returns: An instance of `FixtureRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> IFixtureRepository {
    return FixtureRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Line-Up Repository Bindings

/// Provides a concrete binding for `ILineUPRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `LineUpRepository` wired up with the shared `HTTPClient`.
final public class LineUpRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `ILineUPRepository` implementation.
  ///
  /// - Returns: An `actor` instance of `LineUpRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> ILineUPRepository {
    return LineUpRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Ranking Repository Bindings

/// Provides a concrete binding for `IRankingRepository`.
///
/// This class conforms to `IBindings` and delivers an `actor` instance of
/// `RankingRepository` wired up with the shared `ExHttpConnect` client.
final public class RankingRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `IRankingRepository` implementation.
  ///
  /// - Returns: An instance of `RankingRepository` using the global `ExHttpConnect` client.
  /// - Note: `ExHttpConnect.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> IRankingRepository {
    return RankingRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Standings Repository Bindings

/// Provides a concrete binding for `IStandingRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `StandingsRepository` wired up with the shared `HTTPClient`.
final public class StandingsRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `IStandingRepository` implementation.
  ///
  /// - Returns: An instance of `StandingsRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> IStandingRepository {
    return StandingsRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Statistics Repository Bindings

/// Provides a concrete binding for `IStatisticsRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `StatisticsRepository` wired up with the shared `HTTPClient`.
final public class StatisticsRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `IStatisticsRepository` implementation.
  ///
  /// - Returns: An instance of `StatisticsRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> IStatisticsRepository {
    return StatisticsRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Team Repository Bindings

/// Provides a concrete binding for `ITeamRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `TeamRepository` wired up with the shared `HTTPClient`.
final public class TeamRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `ITeamRepository` implementation.
  ///
  /// - Returns: An instance of `TeamRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> ITeamRepository {
    return TeamRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Top Performers Repository Bindings

/// Provides a concrete binding for `ITopPerformersRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `TopPerformersRepository` wired up with the shared `HTTPClient`.
final public class TopPerformersRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `ITopPerformersRepository` implementation.
  ///
  /// - Returns: An instance of `TopPerformersRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> ITopPerformersRepository {
    return TopPerformersRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Top Turnements Repository Bindings

/// Provides a concrete binding for `ITopTurnementsRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `TopTurnementsRepository` wired up with the shared `HTTPClient`.
final public class TopTurnementsRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `ITopTurnementsRepository` implementation.
  ///
  /// - Returns: An instance of `TopTurnementsRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> ITopTurnementsRepository {
    return TopTurnementsRepository(client: try! HTTPClient.getClient())
  }
}

// MARK: - Venues Repository Bindings

/// Provides a concrete binding for `IVenuesRepository`.
///
/// This class conforms to `IBindings` and delivers an instance of
/// `VenuesRepository` wired up with the shared `HTTPClient`.
final public class VenuesRepositoryBindings: IBindings {

  public init() {}
  /// Returns a configured `IVenuesRepository` implementation.
  ///
  /// - Returns: An instance of `VenuesRepository` using the global `HTTPClient`.
  /// - Note: `HTTPClient.getClient()` may throw; this binding force‑unwraps with `try!`.
  public func getDependency() -> IVenuesRepository {
    return VenuesRepository(client: try! HTTPClient.getClient())
  }
}

final public class PlayerProfileRepositoryBindings: IBindings {
  public init() {}

  public func getDependency() -> IPlayerProfileRepository {
    return PlayerProfileRepository(client: try! HTTPClient.getClient())
  }
}

final public class TrophiesRepositoryBindings: IBindings {
    
  public init() {}

  public func getDependency() -> ITrophiesRepository {
    return TrophiesRepository(client: try! HTTPClient.getClient())
  }
}
