import Foundation

struct EmptyResponse: Decodable {}

final class FavoriteManager {

    static let shared = FavoriteManager()

    func setFavorite(
        placeId: Int,
        isFavorite: Bool
    ) async throws {

        guard let token = KeychainService.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }

        _ = try await ApiClient.shared.request(
            "\(APIConstants.baseURL)/places/\(placeId)/favorite",
            method: .post,
            body: ["favorite": isFavorite],
            token: token,
            contentType: .formURLEncoded
        ) as EmptyResponse
    }
}
