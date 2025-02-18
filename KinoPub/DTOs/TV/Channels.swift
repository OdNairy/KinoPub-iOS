import Foundation

public struct Channels: Codable {
    // MARK: Properties
    public let id: Int
    public let name: String
    public let title: String
    public let logos: Logos
    public let stream: String

    @EmptyStringAsNil
    public var current: String? // empty instead of nil
    public let embed: String?
    public let playlist: String?
}
