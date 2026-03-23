import UIKit

class LocationCardView: UIView {
    
    private let card: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderClr.cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let locationImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "testt")
        img.contentMode = .scaleToFill
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private let favorite: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = .lightGray
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 9
        return btn
    }()
    
    private var isFavorite = false
    
    let locationName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_SemiBold", size: 12)
        lbl.textColor = .black
        lbl.text = "Collesuem"
        return lbl
    }()
    
    private let locationIcon: UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(named: "location")
        return icon
    }()
    
    let locationGeo: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Light", size: 8)
        lbl.textColor = .black
        lbl.text = "Rome"
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
        isFavorite.toggle()
        favorite.tintColor = isFavorite ? .red : .lightGray
        print("favorite tapped")
    }
    
    private func setupUI() {
        addSubview(card)
        card.addSubview(locationImage)
        locationImage.addSubview(favorite)
        card.addSubview(locationInfoStack)
    }
    
    func configure(image: UIImage?, name: String) {
        locationImage.image = image
        locationName.text = name
    }
    
    private func setupConstraints() {
        [card, locationImage, favorite, locationInfoStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            locationImage.topAnchor.constraint(equalTo: card.topAnchor, constant: 3),
            locationImage.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            locationImage.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            
            favorite.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 10),
            favorite.leadingAnchor.constraint(equalTo: locationImage.leadingAnchor, constant: 97),
            favorite.widthAnchor.constraint(equalToConstant: 18),
            favorite.heightAnchor.constraint(equalToConstant: 18),
            
            locationInfoStack.topAnchor.constraint(equalTo: locationImage.bottomAnchor),
            locationInfoStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8),
            
        ])
    }
}
