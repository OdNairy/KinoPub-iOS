import Foundation

public struct Countries: Codable, Hashable, Equatable, CustomStringConvertible {
    public let id: Int
    public let title: String

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var description: String {
        return title
    }
}

public func ==(lhs: Countries, rhs: Countries) -> Bool {
    return lhs.id == rhs.id
}
