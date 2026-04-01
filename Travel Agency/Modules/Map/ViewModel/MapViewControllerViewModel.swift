import Foundation

protocol MapViewControllerViewModelInputProtocol: AnyObject {
    var places: [MapModel] { get }
    
    func fetchPlaces() async throws -> [MapModel]
}

final class MapViewControllerViewModel: MapViewControllerViewModelInputProtocol {
    private(set) var places: [MapModel] = []
    
    func fetchPlaces() async throws -> [MapModel] {
        
        let result: [MapModel] = try await ApiClient.shared.request(
            "https://travel-qdi5.onrender.com/places"
        )
        
        self.places = result
        return result
    }
}

