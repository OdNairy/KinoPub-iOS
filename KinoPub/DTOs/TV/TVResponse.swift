import Foundation

public struct TVRequest: Codable {
    public var status: Int
    public var channels: [Channels]
}
