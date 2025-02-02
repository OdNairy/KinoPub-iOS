import ObjectMapper
import Alamofire

extension DataRequest {
    @discardableResult
    func responseObject<T: BaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (T?, Error?) -> Void) -> Self {
        return validate().responseObject(queue: queue, keyPath: keyPath, mapToObject: object, context: context) { (
            response: DataResponse<T>
        ) in

            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    completionHandler(response.result.value, nil)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
    }

    @discardableResult
    public func responseArray<T: BaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, context: MapContext? = nil, completionHandler: @escaping ([T]?, Error?) -> Void) -> Self {
        return validate().responseArray(queue: queue, keyPath: keyPath, context: context) { (response: DataResponse<[T]>) in
            switch response.result {
                case .success:
                    if response.response?.statusCode == 200 {
                        completionHandler(response.result.value, nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                completionHandler(nil, error)
            }
        }
    }

}
