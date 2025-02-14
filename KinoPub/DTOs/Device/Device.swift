import Foundation

public class Device: Codable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let updated = "updated"
    static let hardware = "hardware"
    static let lastSeen = "last_seen"
    static let id = "id"
    static let created = "created"
    static let title = "title"
    static let software = "software"
  }

  // MARK: Properties
  public var updated: Int!
  public var hardware: String!
  public var lastSeen: Int!
  public var id: Int!
  public var created: Int!
  public var title: String!
  public var software: String!
}
