import Foundation

public class Watching: Codable {
    public var status: Status!
    public var time: Double?
}

public class WatchingToggle: Codable {

//    private struct SerializationKeys {
//        static let status = "status"
//        static let watched = "watched"
//        static let watching = "watching"
//        static let watching2 = "watching"
//    }

    public var status: Int!
    public var watched: Int!
    public var watching: Bool!
    #warning("watching2 – нет парсинга")
    public var watching2: Watching!

//    public func mapping(map: Map) {
//        status <- map[SerializationKeys.status]
//        watched <- map[SerializationKeys.watched]
//        watching <- map[SerializationKeys.watching]
//        watching2 <- map[SerializationKeys.watching2]
//    }
}
