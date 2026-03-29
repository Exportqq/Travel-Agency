final class MainViewControllerViewModel {
    
    func fetchPlaces() async throws -> [MainModel] {
        let result: [MainModel] = try await ApiClient.shared.request(
            "https://travel-qdi5.onrender.com/places"
        )
        return result
    }
}
