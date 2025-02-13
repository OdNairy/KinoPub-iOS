import Foundation
import ObjectMapper

public struct DeviceRequest: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let device = "device"
        static let status = "status"
    }

    // MARK: Properties
    public var device: Device!
    public var status: Int!

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        device <- map[SerializationKeys.device]
        status <- map[SerializationKeys.status]
    }
}
