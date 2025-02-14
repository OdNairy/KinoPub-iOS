import Foundation

public class Bookmarks: Codable {
    public var updated: Int!
    public var title: String!
    public var views: Int!
    public var id: Int!
    public var created: Int!
    public var count: String!
}

public class BookmarksToggle: Codable {
    public var status: Int?
    public var exists: Bool?
}
