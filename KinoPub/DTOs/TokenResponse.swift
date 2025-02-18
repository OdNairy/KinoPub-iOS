import Foundation

public struct TokenResponse: Codable {
    public var refreshToken: String
    public var accessToken: String
    public var expiresIn: Int

    private enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
}
