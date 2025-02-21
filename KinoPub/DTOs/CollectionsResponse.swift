import Foundation

public struct CollectionsResponse: Codable {
    public var items: [Collections]!
    public var status: Int!
    public var pagination: Pagination!
}
