import UIKit

class CategoriesCardView: UIView {
    
    private let card: UIView = {
        let view = UIView()
        view.backgroundColor = .searchClr
        view.layer.cornerRadius = 34
        return view
    }()
    
    let categoriesImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mount")
        return image
    }()
    
    let categoriesTitle: UILabel = {
        let label = UILabel()
        label.text = "Mountain"
        label.font = UIFont(name: "Inter-Regular_Medium", size: 9)
        label.textColor = .black
        return label
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
        addSubview(card)
        card.addSubview(categoriesImage)
        addSubview(categoriesTitle)
    }
    
    func configure(icon: UIImage?, name: String) {
        categoriesImage.image = icon
        categoriesTitle.text = name
    }
    
    private func setupConstrains() {
        [card, categoriesImage, categoriesTitle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: self.topAnchor),
            card.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            card.heightAnchor.constraint(equalToConstant: 68),
            card.widthAnchor.constraint(equalToConstant: 68),
            
            categoriesImage.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            categoriesImage.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            
            categoriesTitle.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 7),
            categoriesTitle.centerXAnchor.constraint(equalTo: card.centerXAnchor)
        ])
    }
}

