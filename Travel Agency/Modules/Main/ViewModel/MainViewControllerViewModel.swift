import Foundation

protocol MainViewControllerViewModelInputProtocol: AnyObject {
    var mainTitle: String { get }
    var mainText: String { get }
    var mainPlaces: String { get }
    
    func fetchPlaces() async throws -> [MainModel]

}

final class MainViewControllerViewModel: MainViewControllerViewModelInputProtocol {
    var mainTitle: String = "Where do"
    var mainText: String = "you want to go?"
    var mainPlaces: String = "Explore Cities"
    
    private(set) var places: [MainModel] = []
    
    func fetchPlaces() async throws -> [MainModel] {
        
        let result: [MainModel] = try await ApiClient.shared.request(
            "https://travel-qdi5.onrender.com/places"
        )
        
        self.places = result
        return result
    }
}


