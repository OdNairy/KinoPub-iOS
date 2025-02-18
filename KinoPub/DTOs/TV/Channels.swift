import Foundation

public struct Channels: Codable {
    // MARK: Properties
    public var id: Int
    public var name: String
    public var title: String
    public var logos: Logos
    public var stream: String

    @EmptyStringAsNil
    public var current: String? // empty instead of nil
    public var embed: String?
    public var playlist: String?
}
