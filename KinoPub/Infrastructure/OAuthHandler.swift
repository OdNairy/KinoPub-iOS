import Alamofire
import Foundation

// import Crashlytics

protocol OAuthHandlerDelegate: AnyObject {
    func handlerDidUpdate(accessToken token: String, refreshToken: String)
    func handlerDidFailedToUpdateToken()
    func refreshTokenRequest() -> DataRequest
}

class OAuthHandler: RequestInterceptor {
    private typealias RefreshCompletion = (
        _ success: Bool, _ accessToken: String?, _ refreshToken: String?
    ) -> Void

    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        return Session(configuration: configuration)
    }()

    private let lock = NSLock()

    private var accessToken: String

    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []

    weak var delegate: OAuthHandlerDelegate?

    public init(accessToken: String) {
        self.accessToken = accessToken
    }

    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        if let url = urlRequest.url, !url.path.hasPrefix("oauth2") {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        completion(.success(urlRequest))
    }

    // MARK: - RequestRetrier
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: any Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        lock.lock()
        defer { lock.unlock() }

        //        Answers.logCustomEvent(withName: "RequestRetrier", customAttributes: ["ERROR:": error, "Status Code": (request.task?.response as? HTTPURLResponse)?.statusCode ?? "unknown"])

        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)

            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                    guard let strongSelf = self else { return }

                    strongSelf.lock.lock()
                    defer { strongSelf.lock.unlock() }

                    if let accessToken = accessToken, let refreshToken = refreshToken {
                        strongSelf.accessToken = accessToken
                        strongSelf.delegate?.handlerDidUpdate(
                            accessToken: accessToken, refreshToken: refreshToken)
                    }

                    strongSelf.requestsToRetry.forEach { $0(.retry) }
                    strongSelf.requestsToRetry.removeAll()

                    if !succeeded {
                        strongSelf.delegate?.handlerDidFailedToUpdateToken()
                    }
                }
            }
        } else {
            completion(.doNotRetry)
        }
    }

    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }

        isRefreshing = true
        let request = delegate!.refreshTokenRequest()
        request.validate()
            .responseObject { (value: TokenResponse?, error) in
                if let value {
                    completion(true, value.accessToken, value.refreshToken)
                } else {
                    completion(false, nil, nil)
                }
//                    Answers.logCustomEvent(withName: "refreshTokens", customAttributes: ["Error": response.error ?? "unknown"])
            }
    }
}
