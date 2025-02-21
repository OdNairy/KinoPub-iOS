import Foundation

public struct Videos: Codable {
    public var files: [Files]!
    public var subtitles: [Subtitles]!
    public var id: Int!
    public var thumbnail: String!
    public var tracks: Int
    public var number: Int!
    public var title: String!
    public var duration: Int!
    public var watched: Int!
    public var watching: Watching!
}
