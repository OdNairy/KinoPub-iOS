import Foundation
import ObjectMapper

public struct TVRequest: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let status = "status"
        static let channels = "channels"
    }

    // MARK: Properties
    public var status: Int?
    public var channels: [Channels]?

    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public init?(map: Map) {

    }

    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public mutating func mapping(map: Map) {
        status <- map[SerializationKeys.status]
        channels <- map[SerializationKeys.channels]
    }

}
