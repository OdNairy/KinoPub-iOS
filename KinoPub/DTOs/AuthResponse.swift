import Foundation

public struct AuthResponse: Codable {
    public let userCode: String
    public let verificationUri: String
    public let interval: Int
    public let code: String
    public let expiresIn: Int

    private enum CodingKeys: String, CodingKey {
        case userCode = "user_code"
        case verificationUri = "verification_uri"
        case interval
        case code
        case expiresIn = "expires_in"
    }
}
