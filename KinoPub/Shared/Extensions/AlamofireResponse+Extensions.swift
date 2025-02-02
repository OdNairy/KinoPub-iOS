import ObjectMapper
import Alamofire

extension DataRequest {
    @discardableResult
    func responseObject<T: BaseMappable>(queue: DispatchQueue = .main, keyPath: String? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (T?, Error?) -> Void) -> Self {
        return validate().responseObject(queue: queue, keyPath: keyPath, mapToObject: object, context: context) { (
            response: AFDataResponse<T>
        ) in

            switch response.result {
            case .success(let value):
                if response.response?.statusCode == 200 {
                    completionHandler(value, nil)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
    }

    @discardableResult
    public func responseArray<T: BaseMappable>(queue: DispatchQueue = .main, keyPath: String? = nil, context: MapContext? = nil, completionHandler: @escaping ([T]?, Error?) -> Void) -> Self {
        return validate().responseArray(queue: queue, keyPath: keyPath, context: context) { (response: AFDataResponse<[T]>) in
            switch response.result {
                case .success(let value):
                    if response.response?.statusCode == 200 {
                        completionHandler(value, nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                completionHandler(nil, error)
            }
        }
    }

}
