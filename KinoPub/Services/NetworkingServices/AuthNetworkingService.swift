import Alamofire
import Foundation

class AuthNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveDeviceCode(
        completed: @escaping (_ responseObject: AuthResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveDeviceCodeRequest()
            .responseObject(completionHandler: completed)
    }

    func checkApproved(
        withCode code: String,
        completed: @escaping (_ responseObject: TokenResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveCheckCodeApproveRequest(code)
            .responseObject(completionHandler: completed)
    }
}
