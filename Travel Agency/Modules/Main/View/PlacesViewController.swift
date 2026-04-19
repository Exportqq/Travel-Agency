import UIKit
import Kingfisher

final class PlacesCollectionView: UIViewController {
    
    var onPlacesSelected: ((MainModel) -> Void)?
    
    private let viewModel = MainViewControllerViewModel()
    
    private var allPlaces: [MainModel] = []
    private var places: [MainModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 9
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 37)
        
        cv.register(LocationCell.self, forCellWithReuseIdentifier: "LocationCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        fetchPlaces()
    }
    
    private func fetchPlaces() {
        Task {
            do {
                try await viewModel.fetchPlaces()
                
                DispatchQueue.main.async {
                    self.allPlaces = self.viewModel.places
                    self.places = self.viewModel.places
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("error:", error)
            }
        }
    }
    
    func filterPlacesByName(_ name: String) {
        
        if name.isEmpty {
            places = allPlaces
        } else {
            places = allPlaces.filter {
                $0.name?.lowercased().contains(name.lowercased()) ?? false
            }
        }
        
        collectionView.reloadData()
    }
}

extension PlacesCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "LocationCell",
            for: indexPath
        ) as! LocationCell
        
        let place = places[indexPath.item]
        
        let baseUrl = "https://travel-qdi5.onrender.com"
        let fullUrl = baseUrl + (place.img ?? "")
        
        cell.card.configure(
            imageUrl: fullUrl,
            name: place.name ?? "",
            geo: place.country ?? "",
            placeId: place.id,
            isFavorite: place.isFavorite ?? false
        )
        
        return cell
    }
}

extension PlacesCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 126, height: 177)
    }
}

extension PlacesCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = places[indexPath.item]
        onPlacesSelected?(selectedPlace)
    }
}
