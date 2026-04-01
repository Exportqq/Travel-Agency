//import UIKit
//import MapKit
//
//class MapViewController: UIViewController {
//
//    private var mapView: MKMapView!
//    private var collectionView: UICollectionView!
//
//    private let locations: [Map] = [
//        Location(id: 21, name: "Dubai Desert Conservation Reserve", country: "UAE", lat: 24.8135, lng: 55.641, link: "https://www.ddcr.org/", img: "/uploads/7407a214-39d5-4822-a191-49f010c1d8ca_66.png", rating: "4.9"),
//        Location(id: 23, name: "Yellowstone National Park", country: "USA", lat: 44.428, lng: 110.5885, link: "https://www.nps.gov/yell/index.htm", img: "/uploads/d65ffc72-d48f-49f2-8584-9b081c3c0656_88.png", rating: "4.8"),
//        Location(id: 24, name: "Banff National Park", country: "Canada", lat: 51.4968, lng: 115.9281, link: "https://parks.canada.ca/pn-np/ab/banff", img: "/uploads/d5df8421-cf7a-4466-a615-1c82ddccbeb3_99.png", rating: "4.7"),
//        Location(id: 27, name: "Santorini", country: "Greece", lat: 36.3932, lng: 25.4615, link: "https://santorini.gr/", img: "/uploads/4bedaae2-0429-4b68-8862-0c1004351010_123.png", rating: "4.8")
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Карта"
//
//        setupMapView()
//        setupCollectionView()
//    }
//
//    private func setupMapView() {
//        mapView = MKMapView(frame: view.bounds)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.mapType = .satellite
//        view.addSubview(mapView)
//
//        let worldRegion = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
//            span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 180)
//        )
//        mapView.setRegion(worldRegion, animated: false)
//    }
//
//    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 250, height: 100)
//        layout.minimumLineSpacing = 15
//
//        collectionView = UICollectionView(frame: CGRect(x: 37, y: view.bounds.height - 220, width: view.bounds.width, height: 100), collectionViewLayout: layout)
//        collectionView.backgroundColor = .clear
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
//
//        // Используем существующий класс
//        collectionView.register(MapLocationCell.self, forCellWithReuseIdentifier: "MapLocationCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        view.addSubview(collectionView)
//    }
//
//    private func focusOnLocation(_ location: Location) {
//        let coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
//        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
//        mapView.setRegion(region, animated: true)
//
//        mapView.removeAnnotations(mapView.annotations)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        annotation.title = location.name
//        mapView.addAnnotation(annotation)
//    }
//}
//
//extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return locations.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapLocationCell", for: indexPath) as? MapLocationCell else {
//            return UICollectionViewCell()
//        }
//        cell.configure(with: locations[indexPath.item])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let location = locations[indexPath.item]
//        focusOnLocation(location)
//    }
//}

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let viewModel = MapViewControllerViewModel()
    
    private var mapView: MKMapView!

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 14
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.decelerationRate = .fast
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(MapLocationCell.self, forCellWithReuseIdentifier: "MapLocationCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupView()
        setupConstraints()
        fetchFavorites()
    }
        
    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(mapView)
        view.addSubview(collectionView)
        
    }
    
    private func setupMapView() {
       mapView = MKMapView(frame: view.bounds)
       mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       mapView.mapType = .satellite
       view.addSubview(mapView)

       let worldRegion = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
           span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 180)
       )
       mapView.setRegion(worldRegion, animated: false)
   }
    
    private func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.heightAnchor.constraint(equalToConstant: 151),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        ])
    }
        
    private func fetchFavorites() {
        Task {
            do {
                try await viewModel.fetchPlaces()
                                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("Error:", error)
            }
        }
    }
}


extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapLocationCell", for: indexPath) as!
        MapLocationCell
        
        let place = viewModel.places[indexPath.item]
        
        let baseUrl = "https://travel-qdi5.onrender.com"
        let fullUrl = baseUrl + (place.img ?? "")
        
        cell.card.configure(
            imageUrl: fullUrl,
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 274, height: 151)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


