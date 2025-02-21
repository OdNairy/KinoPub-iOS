import Foundation

@propertyWrapper
public struct IntOrString: Codable {
    public var wrappedValue: Int?

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            wrappedValue = intValue
        } else if let stringValue = try? container.decode(String.self), let intValue = Int(stringValue) {
            wrappedValue = intValue
        } else {
            wrappedValue = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = wrappedValue {
            try container.encode(value)
        } else {
            try container.encodeNil()
        }
    }
}

