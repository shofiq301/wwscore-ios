// NewsResponse.swift

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable, Sendable {
    let status: Bool?
    let message: String?
    let data: NewsDataClass?
}

// MARK: - DataClass
struct NewsDataClass: Codable, Sendable {
    let page, limit, totalDocuments, totalPage: Int?
    let hasNext, hasPrev: Bool?
    let docs: [NewsDoc]?
}

// MARK: - Doc
public struct NewsDoc: Codable, Sendable, Identifiable,Hashable {
    public let id, title, content: String?
    let image: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, content, image, createdAt
    }
    
    
    func getTimeAgo() -> String {
        guard let createdAt = createdAt else { return "Unknown time" }

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = formatter.date(from: createdAt) else { return "Unknown time" }

        let now = Date()
        let secondsAgo = Int(now.timeIntervalSince(date))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        let year = 365 * day

        switch secondsAgo {
        case 0..<minute:
            return "\(secondsAgo) second\(secondsAgo == 1 ? "" : "s") ago"
        case minute..<hour:
            let minutes = secondsAgo / minute
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        case hour..<day:
            let hours = secondsAgo / hour
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        case day..<week:
            let days = secondsAgo / day
            return "\(days) day\(days == 1 ? "" : "s") ago"
        case week..<month:
            let weeks = secondsAgo / week
            return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        case month..<year:
            let months = secondsAgo / month
            return "\(months) month\(months == 1 ? "" : "s") ago"
        default:
            let years = secondsAgo / year
            return "\(years) year\(years == 1 ? "" : "s") ago"
        }
    }
}
