import Foundation

public class Settings: Codable {
    public var showErotic: Bool! = false
    public var showUncertain: Bool! = false

    private enum CodingKeys: String, CodingKey {
        case showErotic = "show_erotic"
        case showUncertain = "show_uncertain"
    }
}
