import Foundation

protocol FavoriteViewModelInputProtocol: AnyObject {
    var mainText: String { get }
    var places: [MainModel] { get }
    
    func fetchPlaces() async throws -> [MainModel]
}

final class FavoriteViewModel: FavoriteViewModelInputProtocol {
    var mainText: String = "Your Favorite"
    
    private(set) var places: [MainModel] = []
    
    func fetchPlaces() async throws -> [MainModel] {
        
        let result: [MainModel] = try await ApiClient.shared.request(
            "https://travel-qdi5.onrender.com/places"
        )
        
        self.places = result.filter { $0.isFavorite == true }
        return result
    }
}
