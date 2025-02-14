import Foundation

public class Countries: Codable, Hashable, Equatable, CustomStringConvertible {
    public var id: Int!
    public var title: String!

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var description: String {
        return title!
    }
}

public func ==(lhs: Countries, rhs: Countries) -> Bool {
    return lhs.id == rhs.id
}
