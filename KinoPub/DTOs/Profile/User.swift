import Foundation

public struct User: Codable {
    public let regDate: Int
    public let subscription: Subscription
    public let settings: Settings
    public let username: String
    public let profile: Profile

    private enum CodingKeys: String, CodingKey {
        case regDate = "reg_date"
        case subscription
        case settings
        case username
        case profile
    }
}
