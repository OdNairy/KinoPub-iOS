import Foundation

public class TVRequest: Codable {
    public var status: Int?
    public var channels: [Channels]?
}
