import Alamofire
import AlamofireObjectMapper
import Foundation

class CollectionsNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveCollections(
        page: String,
        completed: @escaping (_ responseObject: CollectionsResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveCollectionsRequest(page: page)
            .responseObject(completionHandler: completed)
    }
}
