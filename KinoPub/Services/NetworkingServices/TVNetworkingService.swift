import Alamofire
import Foundation

class TVNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveTVChanels(
        completed: @escaping (_ responseArray: [Channels]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveTVChanelsRequest()
            .responseArray(keyPath: "channels", completionHandler: completed)
    }
}
