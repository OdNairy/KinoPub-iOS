import Foundation

@propertyWrapper
public struct EmptyStringAsNil: Codable {
    public var wrappedValue: String?

    public init(wrappedValue: String?) {
        self.wrappedValue = (wrappedValue?.isEmpty ?? true) ? nil : wrappedValue
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String?.self)
        self.wrappedValue = value?.isEmpty == true ? nil : value
    }
}
