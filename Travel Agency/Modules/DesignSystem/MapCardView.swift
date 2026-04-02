import UIKit
import Kingfisher

class MapCardView: UIView {
    
    private let mapBakcgroud: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let mapImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 15
        return img
    }()
    
    private let mapLocationTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    private let mapLocationGeo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Medium", size: 10)
        label.textColor = .textGrey
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mapLocationTitle, mapLocationGeo])
        stack.axis = .vertical
        stack.spacing = 1
        return stack
    }()
    
    private let starImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "star")
        return img
    }()
    
    private let mapLocationRaiting: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var stackViewRaiting: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starImg, mapLocationRaiting])
        stack.axis = .horizontal
        stack.spacing = 1
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(mapBakcgroud)
        addSubview(mapImg)
        addSubview(stackView)
        addSubview(stackViewRaiting)
    }
    
    func configure(imageUrl: String, name: String, geo: String, raiting: String) {
        if let url = URL(string: imageUrl) {
            mapImg.kf.setImage(
                with: url)
        }
        
        mapLocationTitle.text = name
        mapLocationGeo.text = geo
        mapLocationRaiting.text = "\(raiting)"
    }
    
    private func setupConstrains() {
        [mapBakcgroud, mapImg, stackView, stackViewRaiting].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mapBakcgroud.topAnchor.constraint(equalTo: self.topAnchor, constant: 51),
            mapBakcgroud.heightAnchor.constraint(equalToConstant: 100),
            mapBakcgroud.widthAnchor.constraint(equalToConstant: 274),
            mapBakcgroud.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            mapImg.topAnchor.constraint(equalTo: self.topAnchor),
            mapImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mapImg.heightAnchor.constraint(equalToConstant: 84),
            mapImg.widthAnchor.constraint(equalToConstant: 84),
            
            stackView.topAnchor.constraint(equalTo: mapImg.bottomAnchor, constant: 14),
            stackView.leadingAnchor.constraint(equalTo: mapImg.leadingAnchor, constant: 4),
            
            starImg.heightAnchor.constraint(equalToConstant: 23),
            starImg.widthAnchor.constraint(equalToConstant: 23),
            
            stackViewRaiting.topAnchor.constraint(equalTo: mapBakcgroud.topAnchor, constant: 20),
            stackViewRaiting.trailingAnchor.constraint(equalTo: mapBakcgroud.trailingAnchor, constant: -20)
        ])
    }
}

