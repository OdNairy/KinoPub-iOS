import Foundation

public struct Device: Codable {

    // MARK: Properties
    public let updated: Int
    public let hardware: String
    public let lastSeen: Int
    public let id: Int
    public let created: Int
    public let title: String
    public let software: String

    enum CodingKeys: String, CodingKey {
        case updated
        case hardware
        case lastSeen = "last_seen"
        case id
        case created
        case title
        case software
    }
}
