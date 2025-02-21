import Alamofire
import Foundation

class AccountNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func notifyAboutDevice(completed: @escaping (_ error: Error?) -> Void) {
        requestFactory.notifyAboutDeviceRequest().validate().responseJSON { response in
            switch response.result {
                case .success:
                    completed(nil)
                case .failure(let error):
                    completed(error)
            }
        }
    }

    func receiveCurrentDevice(
        completed: @escaping (_ responseObject: DeviceRequest?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveCurrentDeviceRequest()
            .responseDecodable(completionHandler: { (resp: AFDataResponse<DeviceRequest>) in
                completed(resp.value, resp.error)
            })
    }

    func unlinkDevice(completed: @escaping (_ error: Error?) -> Void) {
        requestFactory.unlinkDeviceRequest().validate().response { response in
            completed(response.error)
        }
    }

    func receiveUserProfile(
        completed: @escaping (_ responseObject: ProfileRequest?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveUserProfileRequest()
            .responseObject(completionHandler: completed)
    }
}
