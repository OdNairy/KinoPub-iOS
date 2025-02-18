import Foundation

public struct Settings: Codable {
    public let showErotic: Bool
    public let showUncertain: Bool

    private enum CodingKeys: String, CodingKey {
        case showErotic = "show_erotic"
        case showUncertain = "show_uncertain"
    }
}
