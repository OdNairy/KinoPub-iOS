import Foundation

public class Pagination: Codable {
    public var total: Int!
    public var current: Int!
    public var totalItems: Int?
    public var perpage: Int!

    private enum CodingKeys: String, CodingKey {
        case total
        case current
        case totalItems = "total_items"
        case perpage
    }
}
