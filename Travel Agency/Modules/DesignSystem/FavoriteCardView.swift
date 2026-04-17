import UIKit
import Kingfisher

class FavoriteCardView: UIView {
    
    var placeId: Int?
    
    var onFavoriteChanged: ((Bool) -> Void)?
    
    private let card: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderClr.cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favorite: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "heart")
        
        btn.setImage(image, for: .normal)
        btn.tintColor = .lightGray
        btn.backgroundColor = .white
        btn.layer.borderColor = UIColor.searchClr.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 9
        
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 6.6, bottom: 6.6, right: 6.6)
        return btn
    }()
    
    private let locationIcon: UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .textGrey
        return icon
    }()
    
    let locationGeo: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Light", size: 12)
        lbl.textColor = .black
        lbl.text = "Rome"
        return lbl
    }()
    
    let locationName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Bold", size: 20)
        lbl.textColor = .black
        lbl.text = "Collesuem"
        return lbl
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationIcon, locationGeo])
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()
    
    private lazy var locationInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationName, locationStack])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    private var isFavorite = false {
        didSet {
            updateFavoriteUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(card)
        card.addSubview(image)
        card.addSubview(locationInfoStack)
        card.addSubview(favorite)
    }
    
    func configure(imageUrl: String, name: String, geo: String, placeId: Int, isFavorite: Bool) {
        self.placeId = placeId
        self.isFavorite = isFavorite
        
        if let url = URL(string: imageUrl) {
            image.kf.setImage(
                with: url)
        }
        
        locationName.text = name
        locationGeo.text = geo
    }
    
    private func updateFavoriteUI() {
        favorite.tintColor = isFavorite ? .red : .lightGray
    }
    
    private func setupActions() {
        favorite.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteTapped() {
        guard let placeId = self.placeId else { return }

        isFavorite.toggle()

        Task {
            do {
                try await FavoriteManager.shared.setFavorite(
                    placeId: placeId,
                    isFavorite: isFavorite
                )

                await MainActor.run {
                    self.onFavoriteChanged?(self.isFavorite)
                }

            } catch {
                print("Failed: \(error)")

                await MainActor.run {
                    self.isFavorite.toggle()
                }
            }
        }
    }
    
    private func setupConstrains() {
        [card, image, locationInfoStack, favorite].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            locationIcon.heightAnchor.constraint(equalToConstant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            
            card.topAnchor.constraint(equalTo: self.topAnchor),
            card.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            card.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 120),
            image.widthAnchor.constraint(equalToConstant: 120),
            image.topAnchor.constraint(equalTo: card.topAnchor, constant: 6),
            image.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 6),
            
            locationInfoStack.topAnchor.constraint(equalTo: card.topAnchor, constant: 20),
            locationInfoStack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 18),
            
            favorite.topAnchor.constraint(equalTo: image.topAnchor),
            favorite.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -6),
            favorite.heightAnchor.constraint(equalToConstant: 24),
            favorite.widthAnchor.constraint(equalToConstant: 24),
            
            locationName.widthAnchor.constraint(equalToConstant: 160)

        ])
    }
}

