import Foundation
import ObjectMapper

public struct Settings: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let showErotic = "show_erotic"
        static let showUncertain = "show_uncertain"
    }

    // MARK: Properties
    public var showErotic: Bool! = false
    public var showUncertain: Bool! = false

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        showErotic <- map[SerializationKeys.showErotic]
        showUncertain <- map[SerializationKeys.showUncertain]
    }
}
