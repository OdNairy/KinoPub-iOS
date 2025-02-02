import Foundation
import ObjectMapper

public struct CollectionsResponse: Mappable {

    private struct SerializationKeys {
        static let items = "items"
        static let status = "status"
        static let pagination = "pagination"
    }

    // MARK: Properties
    public var items: [Collections]!
    public var status: Int!
    public var pagination: Pagination!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        items <- map[SerializationKeys.items]
        status <- map[SerializationKeys.status]
        pagination <- map[SerializationKeys.pagination]
    }
}
