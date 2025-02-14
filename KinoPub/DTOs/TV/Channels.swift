import Foundation

public class Channels: Codable {
    // MARK: Properties
    public var current: String?
    public var name: String?
    public var id: Int?
    public var logos: Logos?
    public var embed: String?
    public var title: String?
    public var stream: String?
    public var playlist: String?
}
