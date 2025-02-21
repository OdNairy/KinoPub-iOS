import Foundation

public struct ItemResponse: Codable {
    
    public let status: Int
    public let item: Item?
    
    public let pagination: Pagination?
    public let items: [Item]?
}
