import UIKit
import Kingfisher

class LocationDetailViewController: UIViewController {
    
    var placeId: Int?
    var placeUrl: String?
    
    private let locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let favorite: UIButton = {
        let btn = UIButton(type: .system)

        let image = UIImage(named: "heart")?
            .withRenderingMode(.alwaysTemplate)

        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 22

        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 14, left: 11.6, bottom: 11.6, right: 11.6)
        return btn
    }()
    
    private let backBtn: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "back_arrow")

        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 22

        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        return btn
    }()
    
    private let shareBtn: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "share")

        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 22

        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: 11, bottom: 12, right: 11)

        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        view.addSubview(locationImage)
        view.addSubview(favorite)
        view.addSubview(backBtn)
        view.addSubview(shareBtn)
    }
    
    private func SetupConstraints() {
        [locationImage, favorite, backBtn, shareBtn].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
                
        NSLayoutConstraint.activate([
            locationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationImage.heightAnchor.constraint(equalToConstant: 473),
            locationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            backBtn.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 18),
            backBtn.leadingAnchor.constraint(equalTo: locationImage.leadingAnchor, constant: 16),
            backBtn.heightAnchor.constraint(equalToConstant: 42),
            backBtn.widthAnchor.constraint(equalToConstant: 42),
            
            shareBtn.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 18),
            shareBtn.trailingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: -63),
            shareBtn.heightAnchor.constraint(equalToConstant: 42),
            shareBtn.widthAnchor.constraint(equalToConstant: 42),
            
            favorite.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 18),
            favorite.trailingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: -16),
            favorite.heightAnchor.constraint(equalToConstant: 42),
            favorite.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    @objc private func shareTapped() {
        guard let placeUrl,
              let url = URL(string: placeUrl) else {
            return
        }

        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = shareBtn
            popover.sourceRect = shareBtn.bounds
        }

        present(activityVC, animated: true)
    }
    
    private func setupActions() {
        backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        shareBtn.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
    
    func configure(imageUrl: String, name: String, geo: String, placeId: Int, isFavorite: Bool, placeUrl: String) {
        self.placeId = placeId
        self.isFavorite = isFavorite
        self.placeUrl = placeUrl

        if let url = URL(string: imageUrl) {
            locationImage.kf.setImage(
                with: url)
        }
    }
    
    private func updateFavoriteUI() {
        favorite.tintColor = isFavorite ? .red : .lightGray
    }
    
    @objc private func goBack() {
        NavigationHelper.pop(from: self)
    }
    
    private var isFavorite = false {
        didSet {
            updateFavoriteUI()
        }
    }
}
