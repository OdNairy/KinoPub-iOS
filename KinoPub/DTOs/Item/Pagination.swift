import Foundation
import ObjectMapper

public struct Pagination: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let total = "total"
        static let current = "current"
        static let totalItems = "total_items"
        static let perpage = "perpage"
    }

    // MARK: Properties
    public var total: Int!
    public var current: Int!
    public var totalItems: Int?
    public var perpage: Int!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        total <- map[SerializationKeys.total]
        current <- map[SerializationKeys.current]
        totalItems <- map[SerializationKeys.totalItems]
        perpage <- map[SerializationKeys.perpage]
    }
}
