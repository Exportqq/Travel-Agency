import Foundation

protocol FavoriteViewModelInputProtocol: AnyObject {
    var mainText: String { get }
    var places: [FavoriteModel] { get }
    
    func fetchPlaces() async throws -> [FavoriteModel]
}

final class FavoriteViewModel: FavoriteViewModelInputProtocol {
    var mainText: String = "Your Favorite"

    private(set) var places: [FavoriteModel] = []

    func fetchPlaces() async throws -> [FavoriteModel] {
        let result: [FavoriteModel] = try await ApiClient.shared.request(
            "https://travel-qdi5.onrender.com/places"
        )

        self.places = result.filter { $0.isFavorite == true }
        return result
    }

    func removePlace(withId id: Int) -> Int? {
        guard let index = places.firstIndex(where: { $0.id == id }) else {
            return nil
        }

        places.remove(at: index)
        return index
    }
}
