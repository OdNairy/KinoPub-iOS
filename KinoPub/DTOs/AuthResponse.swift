import Foundation

public class AuthResponse: Codable {
    public var userCode: String!
    public var verificationUri: String!
    public var interval: Int!
    public var code: String!
    public var expiresIn: Int!

    private enum CodingKeys: String, CodingKey {
        case userCode = "user_code"
        case verificationUri = "verification_uri"
        case interval
        case code
        case expiresIn = "expires_in"
    }
}
