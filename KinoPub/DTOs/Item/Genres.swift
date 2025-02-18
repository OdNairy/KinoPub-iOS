import Foundation

public struct Genres: Codable, Hashable, Equatable, CustomStringConvertible {
    public var id: Int
    public var title: String
    public var type: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var description: String {
        return title
    }
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

public func ==(lhs: Genres, rhs: Genres) -> Bool {
    return lhs.id == rhs.id
}
