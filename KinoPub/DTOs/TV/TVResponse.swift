import Foundation

public struct TVRequest: Codable {
    public let status: Int
    public let channels: [Channels]
}
