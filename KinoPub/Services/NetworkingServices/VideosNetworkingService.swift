import Alamofire
import AlamofireObjectMapper
import Foundation

class VideosNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveItems(
        withParameters parameters: [String: String], from: String?, cancelPrevious: Bool = false,
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        if cancelPrevious { stopAllSessions() }

        requestFactory.receiveItemsRequest(withParameters: parameters, from: from)
            .responseObject(completionHandler: completed)
    }

    func receiveWatchingSeries(
        _ subscribed: Int,
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveWatchingSeriesRequest(subscribed)
            .responseObject(completionHandler: completed)
    }

    func receiveWatchingMovie(
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveWatchingMovieRequest()
            .responseObject(completionHandler: completed)
    }

    func receiveItemsCollection(
        parameters: [String: String],
        completed: @escaping (_ responseArray: [Item]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveItemsCollectionRequest(parameters: parameters)
            .responseArray(keyPath: "items", completionHandler: completed)
    }

    func receiveSimilarItems(
        id: String, completed: @escaping (_ responseArray: [Item]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveSimilarItemsRequest(id: id)
            .responseArray(keyPath: "items", completionHandler: completed)
    }

    private func stopAllSessions() {
        requestFactory.authorizedSessionManager?.session.getTasksWithCompletionHandler({
            (dataTasks, _, _) in
            dataTasks.forEach { $0.cancel() }
        })
    }
}
