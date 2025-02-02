import Alamofire
import Foundation

class LogViewsNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func changeWatchingStatus(
        id: Int, video: Int?, season: Int, status: Int?,
        completed: @escaping (_ responseObject: WatchingToggle?, _ error: Error?) -> Void
    ) {
        requestFactory.changeWatchingStatusRequest(
            id: id, video: video, season: season, status: status
        )
        .responseObject(completionHandler: completed)
    }

    func changeWatchlist(
        id: String,
        completed: @escaping (_ responseObject: WatchingToggle?, _ error: Error?) -> Void
    ) {
        requestFactory.changeWatchlistRequest(id: id)
            .responseObject(completionHandler: completed)
    }

    func changeMarktime(
        id: Int, time: TimeInterval, video: Int, season: Int?,
        completed: @escaping (_ responseObject: WatchingToggle?, _ error: Error?) -> Void
    ) {
        requestFactory.changeMarktimeRequest(id: id, time: time, video: video, season: season)
            .responseObject(completionHandler: completed)
    }
}
