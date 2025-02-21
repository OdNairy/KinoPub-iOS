import Foundation

public struct Seasons: Codable {
    public var episodes: [Episodes]!
    public let number: Int
    public let title: String!
    public let watching: Watching!

    func sortedEpisodes() -> Seasons {
        var sortedSeason = self
        sortedSeason.episodes.sort { $0.number < $1.number }
        return sortedSeason
    }
}
