import Foundation
import ObjectMapper

public struct Profile: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let avatar = "avatar"
        static let name = "name"
    }

    // MARK: Properties
    public var avatar: String!
    public var name: String!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        avatar <- map[SerializationKeys.avatar]
        name <- map[SerializationKeys.name]
    }
}
