import Alamofire
import AlamofireObjectMapper
import Foundation

class AuthNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveDeviceCode(
        completed: @escaping (_ responseObject: AuthResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveDeviceCodeRequest().responseObject {
            (response: DataResponse<AuthResponse>) in
            switch response.result {
                case .success:
                    completed(response.result.value, nil)
                case .failure(let error):
                    completed(nil, error)
            }
        }
    }

    func checkApproved(
        withCode code: String,
        completed: @escaping (_ responseObject: TokenResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveCheckCodeApproveRequest(code).responseObject {
            (response: DataResponse<TokenResponse>) in
            switch response.result {
                case .success:
                    if response.response?.statusCode == 200 {
                        completed(response.result.value, nil)
                    }
                default:
                    break
            }
        }
    }
}
