import Foundation

public class Item: Codable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private enum CodingKeys: String, CodingKey {
        case countries = "countries"
        case bookmarks = "bookmarks"
        case imdb = "imdb"
        case posters = "posters"
        case langs = "langs"
        case finished = "finished"
        case imdbVotes = "imdb_votes"
        case type = "type"
        case voice = "voice"
        case subtitles = "subtitles"
        case id = "id"
        case ac3 = "ac3"
        case director = "director"
        case videos = "videos"
        case quality = "quality"
        case qualitySeries// = "quality"
        case imdbRating = "imdb_rating"
        case duration = "duration"
        case title = "title"
        case cast = "cast"
        case poorQuality = "poor_quality"
        case subtype = "subtype"
        case ratingPercentageValue = "rating_percentage"
        case genres = "genres"
        case kinopoiskVotes = "kinopoisk_votes"
        case rating = "rating"
        case advert = "advert"
//        case tracklist = "tracklist"
        case views = "views"
        case kinopoiskRating = "kinopoisk_rating"
        case year = "year"
        case ratingVotesValue = "rating_votes"
        case kinopoisk = "kinopoisk"
        case comments = "comments"
        case trailer = "trailer"
        case plot = "plot"
        case inWatchlist = "in_watchlist"
        case subscribed = "subscribed"
        case seasons = "seasons"
        case total = "total"
        case watched = "watched"
//        case new = "new"
    }

    // MARK: Properties
    public var countries: [Countries]?
    public var bookmarks: [Bookmarks]?
    public var imdb: Int?
    public var posters: Posters?
    public var langs: Int?
    public var finished: Bool? = false
    public var imdbVotes: Int?
    public var type: String?
    public var voice: String?
    public var subtitles: String?
    public var id: Int?
    public var ac3: Int?
    public var director: String?
    public var videos: [Episodes]?
    public var quality: Int?
    public var qualitySeries: String?
    public var imdbRating: Double?
    public var duration: Duration?
    public var title: String?
    public var cast: String?
    public var poorQuality: Bool? = false
    public var subtype: String?
    private var ratingPercentageValue: Double?
    public var ratingPercentage: String? {
        return ratingPercentageValue.map { String(format: "%.1f%%", $0 * 100) } ?? ""
    }
    public var genres: [Genres]?
    public var kinopoiskVotes: Int?
    public var rating: Int?
    public var advert: Bool? = false
//    public var tracklist: [Any]?
    public var views: Int?
    public var kinopoiskRating: Double?
    public var year: Int?
    private var ratingVotesValue: Double?
    public var ratingVotes: String? {
        ratingVotesValue.map { String(format: "%.1f", $0) } ?? ""
    }
    public var kinopoisk: Int?
    public var comments: Int?
    public var trailer: Trailer?
    public var plot: String?

    public var inWatchlist: Bool? = false
    public var subscribed: Bool? = false
    public var seasons: [Seasons]?

    public var networks: String?

    public var total: String?
    public var watched: Int?
//    @IntOrString
    public var new: Int? {
        return -1
    }
}
