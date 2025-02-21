import Foundation

public struct Episodes: Codable {
    public let id: Int
    public let title: String
    public let files: [Files]
    public let subtitles: [Subtitles]
    public let thumbnail: String
    public let tracks: Int
    public let number: Int
    public let duration: Double
    public let watched: Int
    public let watching: Watching
}
