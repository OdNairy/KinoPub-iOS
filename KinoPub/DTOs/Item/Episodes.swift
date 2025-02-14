import Foundation

public class Episodes: Codable {
    public var id: Int!
    public var title: String!
    public var files: [Files]!
    public var subtitles: [Subtitles]!
    public var thumbnail: String!
    public var tracks: Int
    public var number: Int!
    public var duration: Double!
    public var watched: Int!
    public var watching: Watching!
}
