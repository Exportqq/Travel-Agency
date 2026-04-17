import UIKit
import Kingfisher

class LocationCardView: UIView {

    var placeId: Int?

    private let card: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderClr.cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    let locationImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 15
        img.isUserInteractionEnabled = true
        return img
    }()

    private let favorite: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "heart")
        
        btn.setImage(image, for: .normal)
        btn.tintColor = .lightGray
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 9
        
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 5, bottom: 5, right: 5)
        return btn
    }()

    private var isFavorite = false {
        didSet {
            updateFavoriteUI()
        }
    }

    let locationName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_SemiBold", size: 12)
        lbl.textColor = .black
        return lbl
    }()

    private let locationIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .textGrey
        
        return icon
    }()

    let locationGeo: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Light", size: 8)
        lbl.textColor = .black
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
        stack.spacing = 2
        stack.alignment = .leading
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                print("status: \(isFavorite)")
            } catch {
                print("Failed: \(error)")
                DispatchQueue.main.async {
                    self.isFavorite.toggle()
                }
            }
        }
    }

    private func setupUI() {
        addSubview(card)
        card.addSubview(locationImage)
        locationImage.addSubview(favorite)
        card.addSubview(locationInfoStack)
    }

    private func setupConstraints() {
        [card, locationImage, favorite, locationInfoStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),

            locationImage.topAnchor.constraint(equalTo: card.topAnchor, constant: 3),
            locationImage.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 3),
            locationImage.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -3),
            locationImage.heightAnchor.constraint(equalToConstant: 120),
            
            locationIcon.heightAnchor.constraint(equalToConstant: 8),
            locationIcon.widthAnchor.constraint(equalToConstant: 8),

            favorite.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 10),
            favorite.leadingAnchor.constraint(equalTo: locationImage.leadingAnchor, constant: 97),
            favorite.widthAnchor.constraint(equalToConstant: 18),
            favorite.heightAnchor.constraint(equalToConstant: 18),

            locationInfoStack.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 12),
            locationInfoStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8),
            
            locationName.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

    func configure(imageUrl: String, name: String, geo: String, placeId: Int, isFavorite: Bool) {
        self.placeId = placeId
        self.isFavorite = isFavorite

        locationName.text = name
        locationGeo.text = geo

        if let url = URL(string: imageUrl) {
            locationImage.kf.setImage(with: url)
        }
    }

    private func updateFavoriteUI() {
        favorite.tintColor = isFavorite ? .red : .lightGray
    }
}
