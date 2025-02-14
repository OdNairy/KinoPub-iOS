import Foundation

public class ItemResponse: Codable {
    
    public var status: Int!
    public var item: Item?
    
    public var pagination: Pagination!
    public var items: [Item]?
}
