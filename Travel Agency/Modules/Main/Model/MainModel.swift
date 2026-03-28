import Foundation

struct MainModel: Decodable {
    let id: Int
    let img: String?
    let name: String?
    let country: String?
    let isFavorite: Bool? // camelCase
    let address: String?
    let open_date: String?
    let link: String?
    let category: String?
    let rating: String?
    let lat: Double?
    let lng: Double?

    enum CodingKeys: String, CodingKey {
        case id, img, name, country
        case isFavorite = "is_favorite"
        case address, open_date, link, category, rating, lat, lng
    }
}
