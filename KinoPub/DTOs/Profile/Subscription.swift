import Foundation

public class Subscription: Codable {
    public var days: Double!
    public var endTime: Int!
    public var active: Bool! = false
    
    private enum CodingKeys: String, CodingKey {
        case days
        case endTime = "end_time"
        case active
    }
}
