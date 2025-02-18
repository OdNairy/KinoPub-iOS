import Foundation
import Eureka

public struct Subtitles: Codable {
    public var shift: Int!
    public var embed: Bool! = false
    public var lang: SubLang!
    public var url: String!
}

public class SubtitlesList: Codable, Equatable, CustomStringConvertible, InputTypeInitiable {

    public required init?(string stringValue: String) {
        return nil
    }
    

    // MARK: Properties
    public var id: String?
    public var title: String?
    
    public var description: String {
        return title!
    }
    public var suggestionString: String {
        return self.id!
    }
    

    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}

public func ==(lhs: SubtitlesList, rhs: SubtitlesList) -> Bool {
    return lhs.id == rhs.id
}
