import Foundation

public struct Pagination: Codable {
    public let total: Int
    public let current: Int
    public let totalItems: Int?
    public let perpage: Int

    private enum CodingKeys: String, CodingKey {
        case total
        case current
        case totalItems = "total_items"
        case perpage
    }
}
