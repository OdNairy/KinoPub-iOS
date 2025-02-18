import Foundation

public struct Settings: Codable {
    public var showErotic: Bool
    public var showUncertain: Bool

    private enum CodingKeys: String, CodingKey {
        case showErotic = "show_erotic"
        case showUncertain = "show_uncertain"
    }
}
