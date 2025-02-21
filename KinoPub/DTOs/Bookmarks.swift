import Foundation

public struct Bookmarks: Codable {
    public var id: Int
    public var title: String
    public var count: String?
    public var views: Int?
    public var updated: Int?
    public var created: Int?
}

public struct BookmarksToggle: Codable {
    public var status: Int?
    public var exists: Bool?
}
