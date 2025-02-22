import Foundation
import ObjectMapper

public struct ProfileRequest: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let status = "status"
        static let user = "user"
    }

    // MARK: Properties
    public var status: Int!
    public var user: User!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        status <- map[SerializationKeys.status]
        user <- map[SerializationKeys.user]
    }
}
