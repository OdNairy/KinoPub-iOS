import ObjectMapper
import Alamofire

extension DataRequest {
    @discardableResult
    func responseObject<T: Codable>(queue: DispatchQueue = .main, keyPath: String? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (T?, Error?) -> Void) -> Self {
        return validate().responseDecodable(of: T.self, queue: queue, decoder: JSONDecoder()) { response in
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
    public func responseArray<T: Codable>(queue: DispatchQueue = .main, keyPath: String? = nil, context: MapContext? = nil, completionHandler: @escaping ([T]?, Error?) -> Void) -> Self {
        let decoder = JSONDecoder()
        if let keyPath {
            decoder.userInfo = [.nestedKey: keyPath as Any]
        }
        return validate()
            .responseDecodable(of: GenericResponse.self, queue: queue, decoder: decoder) { (response: DataResponse<GenericResponse<T>, AFError>) in
                switch response.result {
                case .success(let value):
                    if response.response?.statusCode == 200 {
                        completionHandler(value.values, nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(nil, error)
                }

        }
    }

}

extension CodingUserInfoKey {
    static let nestedKey = CodingUserInfoKey(rawValue: "nestedKey")!
}


struct GenericResponse<T: Decodable>: Decodable {
    let values: [T]

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int? { nil }

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
            guard let key = decoder.userInfo[.nestedKey] as? String else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Не указан ключ для парсинга")
                )
            }
            guard let codingKey = DynamicCodingKeys(stringValue: key) else {
                throw DecodingError.keyNotFound(
                    DynamicCodingKeys(stringValue: key)!,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Ключ \(key) не найден в JSON")
                )
            }
            self.values = try container.decode([T].self, forKey: codingKey)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }

//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//
//        for key in container.allKeys {
//            if let values = try? container.decode([T].self, forKey: key) {
//                self.values = values
//                return
//            }
//        }
//
//        throw DecodingError.dataCorrupted(
//            DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Не найдено подходящее поле с массивом.")
//        )
//    }
}

