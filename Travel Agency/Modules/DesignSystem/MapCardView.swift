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
        img.image = UIImage(named: "testt")
        img.layer.cornerRadius = 15
        return img
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
    }
    
    func configure(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            mapImg.kf.setImage(
                with: url)
        }
    }
    
    private func setupConstrains() {
        [mapBakcgroud, mapImg].forEach {
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
            mapImg.widthAnchor.constraint(equalToConstant: 84)
        ])
    }
}

