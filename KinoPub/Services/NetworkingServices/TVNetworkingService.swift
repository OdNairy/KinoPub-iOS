import Alamofire
import AlamofireObjectMapper
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
            .validate()
            .responseArray(keyPath: "channels") { (response: DataResponse<[Channels]>) in
                switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 {
                            completed(response.result.value, nil)
                        }
                    case .failure(let error):
                        completed(nil, error)
                }
            }
    }
}
