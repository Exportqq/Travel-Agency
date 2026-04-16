import UIKit
import Kingfisher

class LocationDetailViewController: UIViewController {
    
    var placeId: Int?
    
    private let locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let favorite: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = .lightGray
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 22
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        view.addSubview(locationImage)
        view.addSubview(favorite)
    }
    
    private func SetupConstraints() {
        [locationImage, favorite].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
                
        NSLayoutConstraint.activate([
            locationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationImage.heightAnchor.constraint(equalToConstant: 473),
            locationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            favorite.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 18),
            favorite.trailingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: -10),
            favorite.heightAnchor.constraint(equalToConstant: 42),
            favorite.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private var isFavorite = false {
        didSet {
            updateFavoriteUI()
        }
    }
    
    func configure(imageUrl: String, name: String, geo: String, placeId: Int, isFavorite: Bool) {
        self.placeId = placeId
        self.isFavorite = isFavorite

        if let url = URL(string: imageUrl) {
            locationImage.kf.setImage(
                with: url)
        }
    }

    private func updateFavoriteUI() {
        favorite.tintColor = isFavorite ? .red : .lightGray
    }
}
