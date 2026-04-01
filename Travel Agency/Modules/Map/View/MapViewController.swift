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
        
        cv.isPagingEnabled = false
        cv.decelerationRate = .fast
        cv.showsHorizontalScrollIndicator = false
        
        cv.contentInset = UIEdgeInsets(top: 0, left: 37, bottom: 0, right: 37)
        
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
        
       mapView.delegate = self
        
       view.addSubview(mapView)

       let worldRegion = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
           span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 180)
       )
       mapView.setRegion(worldRegion, animated: false)
   }
    
    private func focusOnPlace(_ place: MapModel) {
        guard let lat = place.lat,
              let lng = place.lng else { return }

        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)

        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )

        mapView.setRegion(region, animated: true)
        mapView.removeAnnotations(mapView.annotations)

        let baseUrl = "https://travel-qdi5.onrender.com"
        
        guard let imgPath = place.img,
              !imgPath.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let fullUrl = baseUrl + (imgPath.hasPrefix("/") ? "" : "/") + imgPath

        let annotation = CustomAnnotation(
            coordinate: coordinate,
            title: place.name,
            imageUrl: fullUrl
        )

        mapView.addAnnotation(annotation)
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
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


extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier) as? CustomAnnotationView
        
        if view == nil {
            view = CustomAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
        } else {
            view?.annotation = annotation
        }
        
        view?.configure(with: annotation)
        
        return view
    }
    
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
        
        cell.card.configure(imageUrl: fullUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 274, height: 151)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = viewModel.places[indexPath.item]
        focusOnPlace(place)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                  withVelocity velocity: CGPoint,
                                  targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellWidth = 274 + layout.minimumLineSpacing
        let offset = targetContentOffset.pointee.x + scrollView.contentInset.left
        
        let index = round(offset / cellWidth)
        
        targetContentOffset.pointee = CGPoint(
            x: index * cellWidth - scrollView.contentInset.left,
            y: 0
        )
    }
}


