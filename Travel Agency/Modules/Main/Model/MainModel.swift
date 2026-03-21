import UIKit

struct MainModel: Decodable {
    let id: Int
    let img: String
    let name: String
    let country: String
    let is_favorite: Bool
    let address: String
    let open_date: String
    let images: [String]
    let link: String
    let category: String
    let rating: String
    let lat: Double
    let lng: Double

    var image: UIImage? {
        return UIImage(named: img)
    }
}
