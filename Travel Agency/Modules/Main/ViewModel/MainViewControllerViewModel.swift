import Foundation

protocol MainViewControllerViewModelInputProtocol: AnyObject {
    var mainTitle: String { get }
    var mainText: String { get }
    var mainPlaces: String { get }
    
    func fetchPlaces() async throws -> [MainModel]
    func applyFilters(searchText: String?, category: String?) -> [MainModel]
}

final class MainViewControllerViewModel: MainViewControllerViewModelInputProtocol {
    
    var mainTitle: String = "Where do"
    var mainText: String = "you want to go?"
    var mainPlaces: String = "Explore Cities"
    
    private(set) var places: [MainModel] = []
    private(set) var filteredPlaces: [MainModel] = []
    
    func fetchPlaces() async throws -> [MainModel] {
        let result: [MainModel] = try await ApiClient.shared.request(
            "https://travel-qdi5.onrender.com/places"
        )
        
        self.places = result
        self.filteredPlaces = result
        return result
    }
    
    func applyFilters(searchText: String?, category: String?) -> [MainModel] {
        
        filteredPlaces = places.filter { place in
            
            let matchesSearch =
                searchText?.isEmpty ?? true ||
                place.name?.lowercased().contains(searchText!.lowercased()) ?? false
            
            let matchesCategory =
                category == nil ||
                place.category == category
            
            return matchesSearch && matchesCategory
        }
        
        return filteredPlaces
    }
}
