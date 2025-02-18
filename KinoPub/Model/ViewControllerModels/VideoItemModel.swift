import Foundation
import LKAlertController
import NotificationBannerSwift

protocol VideoItemModelDelegate: AnyObject {
    func didUpdateSimilar()
}

class VideoItemModel {
    weak var delegate: VideoItemModelDelegate?
    var item: Item!
    var mediaItem = MediaItem()
    var mediaItems = [MediaItem]()
    var files: [Files]?
    var parameters = [String: String]()
    var watchingTime: Double = 0
    var similarItems = [Item]()

    let accountManager: AccountManager
    let networkingService: VideosNetworkingService

    init(accountManager: AccountManager) {
        self.accountManager = accountManager
        networkingService = VideosNetworkingService(requestFactory: accountManager.requestFactory)
    }

    func getSeason(_ index: Int) -> Seasons? {
        return item?.seasons?[index]
    }

    func getEpisode(_ index: Int, forSeason seasonIndex: Int) -> Episodes? {
        return item.videos?[index] ?? item.seasons?[seasonIndex].episodes?[index]
    }

    func loadItemsInfo() {
        networkingService.receiveItems(withParameters: parameters, from: item.id?.string) {
            [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if let itemData = response {
                strongSelf.item = itemData.item
                strongSelf.setLinks()
                strongSelf.checkDefaults()
                NotificationCenter.default.post(
                    name: .VideoItemDidUpdate, object: self, userInfo: nil)
            } else {
                Alert(title: "Ошибка", message: error?.localizedDescription)
                    .showOkay()
            }
        }
    }

    func checkDefaults() {
        if Config.shared.canSortSeasons, let seasons = item.seasons {
            item.seasons = seasons.sorted { $0.number! > $1.number! }
        }
        if Config.shared.canSortEpisodes, let seasons = item.seasons {
            var _seasons = [Seasons]()
            for season in seasons {
                season.episodes = season.episodes?.sorted { $0.number > $1.number }
                _seasons.append(season)
            }
            item.seasons = seasons
        }
    }

    func loadSimilarsVideo() {
        guard let idString = item.id?.string else { return }
        networkingService.receiveSimilarItems(id: idString) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if let itemData = response {
                strongSelf.similarItems = itemData
                strongSelf.delegate?.didUpdateSimilar()
            } else {
                Alert(title: "Ошибка", message: error?.localizedDescription)
                    .showOkay()
            }
        }
    }

    private func setLinks() {
        var mediaItem = MediaItem()
        mediaItem.id = item.id
        if let url = item.videos?.first?.files.first?.url?.hls4,
            item.subtype != ItemType.ItemSubtype.multi.rawValue {
            files = item.videos?.first?.files
            mediaItem.title = item.title
            mediaItem.video = item.videos?.first?.number
            mediaItem.url = URL(string: url)
            if item.videos?.first?.watching.status == Status.watching {
                mediaItem.watchingTime = item.videos?.first?.watching.time ?? 0
            }
            mediaItems.append(mediaItem)
        } else {
            print("No unwrapping url")
            if let type = item.type,
                type == ItemType.movies.rawValue
                    || type == ItemType.documovie.rawValue
                    || type == ItemType.concerts.rawValue,
                item.subtype != ItemType.ItemSubtype.multi.rawValue {
                Alert(
                    title: "Ошибка",
                    message:
                        "Не удалось получить ссылку на поток. Возможно, видео находится в обработке. Попробуйте позже."
                )
                .showOkay()
            }
        }

        if item.subtype == ItemType.ItemSubtype.multi.rawValue {
            guard let videos = item.videos else { return }
            for episode in videos {
                if episode.watching.status == Status.watching {
                    mediaItem.watchingTime = episode.watching.time ?? 0
                }
                if episode.watching.status == Status.unwatched
                    || episode.watching.status == Status.watching {
                    guard let url = episode.files.first?.url?.hls4 else { return }

                    var title = episode.title
                    let number = episode.number
                    if title == "" {
                        title = "Episode \(number)"
                    }
                    mediaItem.video = number
                    mediaItem.title = "e\(number) - \(title)"
                    mediaItem.season = 0
                    mediaItem.url = URL(string: url)
                    mediaItems.append(mediaItem)
                    files = episode.files
                }
            }
        }

        if item.type == ItemType.shows.rawValue || item.type == ItemType.docuserial.rawValue
            || item.type == ItemType.tvshows.rawValue {
            var foundSeason = false
            guard let seasons = item.seasons else { return }
            for season in seasons {
                if season.watching?.status == Status.watching
                    || season.watching?.status == Status.unwatched {
                    foundSeason = true
                    guard let episodes = season.episodes else { return }
                    for episode in episodes {
                        if episode.watching.status == Status.watching {
                            mediaItem.watchingTime = episode.watching.time ?? 0
                        }
                        if episode.watching.status == Status.unwatched
                            || episode.watching.status == Status.watching {
                            guard let url = episode.files.first?.url?.hls4 else { return }
                            var title = episode.title
                            let number = episode.number
                            if title == "" {
                                title = "Episode \(number)"
                            }
                            mediaItem.video = number
                            mediaItem.title = "s\(season.number ?? 0)e\(number) - \(title)"
                            mediaItem.season = season.number
                            mediaItem.url = URL(string: url)
                            mediaItems.append(mediaItem)
                            files = episode.files
                        }
                    }
                }
                if foundSeason {
                    break
                }
            }
        }
    }
}
