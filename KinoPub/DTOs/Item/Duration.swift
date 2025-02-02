import Foundation
import ObjectMapper

public struct Duration: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let total = "total"
        static let average = "average"
    }

    // MARK: Properties
    public var total: Double!
    public var average: Double!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        total <- map[SerializationKeys.total]
        average <- map[SerializationKeys.average]
    }
}
