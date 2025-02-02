import Foundation
import ObjectMapper

public struct Logos: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let s = "s"
        static let m = "m"
    }

    // MARK: Properties
    public var s: String?
    public var m: String?

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
        s <- map[SerializationKeys.s]
        m <- map[SerializationKeys.m]
    }

}
