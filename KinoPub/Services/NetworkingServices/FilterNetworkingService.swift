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
            .validate()
            .responseArray(keyPath: "items") { (response: DataResponse<[Genres]>) in
                switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 {
                            completed(response.result.value, nil)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completed(nil, error)
                }
            }
    }

    func receiveItemsCountry(
        completed: @escaping (_ responseArray: [Countries]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveCountryRequest()
            .validate()
            .responseArray(keyPath: "items") { (response: DataResponse<[Countries]>) in
                switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 {
                            completed(response.result.value, nil)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completed(nil, error)
                }
            }
    }

    func receiveSubtitleItems(
        completed: @escaping (_ responseArray: [SubtitlesList]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveSubtitlesRequest()
            .validate()
            .responseArray(keyPath: "items") { (response: DataResponse<[SubtitlesList]>) in
                switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 {
                            completed(response.result.value, nil)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completed(nil, error)
                }
            }
    }
}
