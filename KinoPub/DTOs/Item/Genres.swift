import Foundation

public struct Genres: Codable, Hashable, Equatable, CustomStringConvertible {
    public let id: Int
    public let title: String
    public let type: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var description: String {
        return title
    }
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
        self.type = nil
    }
}

public func ==(lhs: Genres, rhs: Genres) -> Bool {
    return lhs.id == rhs.id
}
