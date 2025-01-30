import Alamofire
import AlamofireObjectMapper
import Foundation

class FilterNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveItemsGenres(
        type: String, completed: @escaping (_ responseArray: [Genres]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveGenresRequest(type: type)
            .responseArray(keyPath: "items", completionHandler: completed)
    }

    func receiveItemsCountry(
        completed: @escaping (_ responseArray: [Countries]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveCountryRequest()
            .responseArray(keyPath: "items", completionHandler: completed)
    }

    func receiveSubtitleItems(
        completed: @escaping (_ responseArray: [SubtitlesList]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveSubtitlesRequest()
            .responseArray(keyPath: "items", completionHandler: completed)
    }
}
