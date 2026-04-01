import Foundation
import MapKit

final class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let imageUrl: String?

    init(coordinate: CLLocationCoordinate2D, title: String?, imageUrl: String?) {
        self.coordinate = coordinate
        self.title = title
        self.imageUrl = imageUrl
    }
}
