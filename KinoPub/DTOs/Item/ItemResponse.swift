import Foundation
import ObjectMapper

public struct ItemResponse: Mappable {

    private struct SerializationKeys {
        static let status = "status"
        static let item = "item"

        static let pagination = "pagination"
        static let items = "items"
    }

    public var status: Int!
    public var item: Item?

    public var pagination: Pagination!
    public var items: [Item]?

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        status <- map[SerializationKeys.status]
        item <- map[SerializationKeys.item]

        pagination <- map[SerializationKeys.pagination]
        items <- map[SerializationKeys.items]
    }
}
