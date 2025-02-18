import Foundation

public struct User: Codable {
    public var regDate: Int
    public var subscription: Subscription
    public var settings: Settings
    public var username: String
    public var profile: Profile

    private enum CodingKeys: String, CodingKey {
        case regDate = "reg_date"
        case subscription
        case settings
        case username
        case profile
    }
}
