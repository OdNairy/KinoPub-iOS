import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        // Если iOS 15+ доступен, используйте встроенный метод
        if #available(iOS 15.0, *) {
            return try await data(from: url)
        } else if #available(iOS 13.0, *) {
            // Реализация для iOS < 15
            return try await withCheckedThrowingContinuation { continuation in
                let task = self.dataTask(with: url) { data, response, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let data = data, let response = response {
                        continuation.resume(returning: (data, response))
                    } else {
                        continuation.resume(throwing: URLError(.badServerResponse))
                    }
                }
                task.resume()
            }
        } else {
            throw URLError(.unsupportedURL)
        }
    }

}
