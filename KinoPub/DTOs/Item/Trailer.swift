import Foundation
import ObjectMapper

public struct Trailer: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let url = "url"
    }

    // MARK: Properties
    public var id: Int!
    public var url: String!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        id <- map[SerializationKeys.id]
        url <- map[SerializationKeys.url]
    }
}
