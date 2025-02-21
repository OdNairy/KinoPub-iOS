import Foundation

public struct Subscription: Codable {
    public let days: Double
    public let endTime: Int?
    public let active: Bool
    
    private enum CodingKeys: String, CodingKey {
        case days
        case endTime = "end_time"
        case active
    }
}
