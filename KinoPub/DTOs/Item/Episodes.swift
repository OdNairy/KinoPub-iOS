import Foundation
import ObjectMapper

public struct Episodes: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let files = "files"
        static let subtitles = "subtitles"
        static let id = "id"
        static let thumbnail = "thumbnail"
        static let tracks = "tracks"
        static let number = "number"
        static let title = "title"
        static let duration = "duration"
        static let watched = "watched"
        static let watching = "watching"
    }

    // MARK: Properties
    public var id: Int!
    public var title: String!
    public var files: [Files]!
    public var subtitles: [Subtitles]!
    public var thumbnail: String!
    public var tracks: String!
    public var number: Int!
    public var duration: Double!
    public var watched: Int!
    public var watching: Watching!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        files <- map[SerializationKeys.files]
        subtitles <- map[SerializationKeys.subtitles]
        id <- map[SerializationKeys.id]
        thumbnail <- map[SerializationKeys.thumbnail]
        tracks <- map[SerializationKeys.tracks]
        number <- map[SerializationKeys.number]
        title <- map[SerializationKeys.title]
        duration <- map[SerializationKeys.duration]
        watched <- map[SerializationKeys.watched]
        watching <- map[SerializationKeys.watching]
    }
}
