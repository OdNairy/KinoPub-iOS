import Foundation

public struct Device: Codable {

    // MARK: Properties
    public var updated: Int
    public var hardware: String
    public var lastSeen: Int
    public var id: Int
    public var created: Int
    public var title: String
    public var software: String

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
