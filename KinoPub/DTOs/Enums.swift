import Foundation
import Eureka

enum GenreType: String {
    case movie = "movie"
    case music = "music"
    case documentary = "docu"
    case tvshow = "tvshow"
}

enum ItemType: String, CustomStringConvertible {
    
    case movies = "movie"
    case shows = "serial"
    case tvshows = "tvshow"
    case movies3d = "3d"
    case concerts = "concert"
    case documovie = "documovie"
    case docuserial = "docuserial"
    case movies4k = "4k"
    
    var description: String {
        switch self {
        case .movies:
            return "Фильмы"
        case .shows:
            return "Сериалы"
        case .tvshows:
            return "ТВ-Шоу"
        case .movies3d:
            return "3D"
        case .concerts:
            return "Концерты"
        case .documovie:
            return "Документальные фильмы"
        case .docuserial:
            return "Документальные сериалы"
        case .movies4k:
            return "4K"
        }
    }
    
    init() {
        self = .movies
    }
    func genre() -> GenreType {
        switch self {
        case .tvshows:
            return .tvshow
        case .movies, .shows, .movies3d, .movies4k:
            return .movie
        case .concerts:
            return .music
        case .documovie, .docuserial:
            return .documentary
        }
    }
    enum ItemSubtype: String {
        case multi = "multi"
    }
}

public enum SubLang: String, Codable, CustomStringConvertible, Equatable {
    case rus = "rus"
    case eng = "eng"
    case ukr = "ukr"
    case fre = "fre"
    case ger = "ger"
    case spa = "spa"
    case ita = "ita"
    case por = "por"
    case fin = "fin"
    case kor = "kor"
    case chi
    case dan
    case gre
    case baq
    case fil
    case glg
    case heb
    case hrv
    case hun
    case ind
    case jpn
    case may
    case nob
    case dut
    case pol
    case rum
    case swe
    case tha
    case tur
    case vie
    case ara
    case cat
    case cze
    case mac
    case slv
    case srp
    case bul
    case ben
    case guj
    case hin
    case kan
    case mal
    case mar
    case nep
    case pan
    case tam
    case tel
    case urd


    case unknown

    public var description: String {
        switch self {
        case .rus:
            return "Русские"
        case .eng:
            return "Английские"
        case .ukr:
            return "Украинские"
        case .fre:
            return "Французкие"
        case .ger:
            return "Немецкие"
        case .spa:
            return "Испанские"
        case .ita:
            return "Итальянские"
        case .por:
            return "Португальские"
        case .fin:
            return "Финские"
        case .kor:
            return "Корейские"
        case .chi:
            return "Китайские"

        case .unknown:
            return "Неизвестные"
        case .dan:
            return "Датские"
        case .gre:
            return "Греческие"
        case .baq:
            return "Баскские"
        case .fil:
            return "Филиппинские"
        case .glg:
            return "Галисийские"
        case .heb:
            return "Иврит"
        case .hrv:
            return "Хорватские"
        case .hun:
            return "Венгерские"
        case .ind:
            return "Индийские"
        case .jpn:
            return "Японские"
        case .may:
            return "Малайские"
        case .nob:
            return "Норвежские"
        case .dut:
            return "Голландские"
        case .pol:
            return "Польские"
        case .rum:
            return "Румынские"
        case .swe:
            return "Шведские"
        case .tha:
            return "Тайские"
        case .tur:
            return "Турецкие"
        case .vie:
            return "Вьетнамские"
        case .ara:
            return "Арабские"
        case .cat:
            return "Каталонские"
        case .cze:
            return "Чешские"
        case .mac:
            return "Македонские"
        case .slv:
            return "Словенские"
        case .srp:
            return "Сербские"
        case .bul:
            return "Болгарские"
        case .ben:
            return "Бенгальские"
        case .guj:
            return "Гуджарати"
        case .hin:
            return "Хинди"
        case .kan:
            return "Каннада"
        case .mal:
            return "Малаялам"
        case .mar:
            return "Маратхи"
        case .nep:
            return "Непальские"
        case .pan:
            return "Пенджабские"
        case .tam:
            return "Тамильские"
        case .tel:
            return "Телугу"
        case .urd:
            return "Урду"
        }
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = SubLang(rawValue: value) ?? .unknown
        if self == .unknown {
            print("Unknown language: \(value)")
        } else {
            let localizedvalue = Locale.current.localizedString(forLanguageCode: value)
            print("Localized language: \(localizedvalue ?? "Unknown"). Original: \(value)")
        }
    }
}

enum SortOption: String, CustomStringConvertible, InputTypeInitiable {
    
    init?(string stringValue: String) {
        return nil
    }
    
    case id
    case year
    case title
    case created
    case updated
    case rating
    case kinopoisk_rating
    case imdb_rating
    case views
    case watchers
    
    static let all = [updated, created, year, title, rating, kinopoisk_rating, imdb_rating, views, watchers]
    
    func name() -> String {
        switch self {
        case .id:
            return "по Id"
        case .year:
            return "по году выпуска"
        case .title:
            return "по названию"
        case .created:
            return "по дате добавления"
        case .updated:
            return "по дате обновления"
        case .rating:
            return "по рейтингу"
        case .kinopoisk_rating:
            return "по кинопоиску"
        case .imdb_rating:
            return "по imdb"
        case .views:
            return "по просмотрам"
        case .watchers:
            return "по кол-ву смотрящих"
        }
    }
    
    func desc() -> String {
        return "-\(self.rawValue)"
    }
    
    func asc() -> String {
        return self.rawValue
    }
    
    var description: String {
        return self.name()
    }
    
    var suggestionString: String {
        return self.rawValue
    }
}

enum TabBarItemTag: Int {
    case movies = 0
    case shows = 1
    case cartoons = 2
    case documovie = 3
    case docuserial = 4
    case tvshow = 5
    case concert = 6
    case bookmarks = 7
    case collections = 8
    case movies4k = 9
    case movies3d = 10
    case newMovies = 11
    case newSeries = 12
    case hotMovies = 13
    case hotSeries = 14
    case freshMovies = 15
    case freshSeries = 16
    
    case watchlist = 99

    var description: String {
        switch self {
        case .newMovies:
            return "Новые фильмы"
        case .newSeries:
            return "Новые сериалы"
        case .hotMovies:
            return "Популярные фильмы"
        case .hotSeries:
            return "Популярные сериалы"
        case .freshMovies:
            return "Свежие фильмы"
        case .freshSeries:
            return "Свежие сериалы"
        default:
            return "default"
        }
    }
}

public enum Status: Int, Codable {
    case unwatched = -1
    case watching = 0
    case watched = 1
}

public enum Serial: Int {
    case watching = 1
    case used = 0
}

enum InWatchlist: String {
    case watching = "Смотрю"
    case willWatch = "Буду смотреть"

}
