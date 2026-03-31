import UIKit

class CategoriesView: UIView {
    
    private let viewModel = CategoriesViewViewModel()
    
    private let categoriesTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Bold", size: 20)
        lbl.textColor = .black
        return lbl
    }()
    
    private let cardsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    private let categories: [(icon: UIImage?, name: String)] = [
        (UIImage(named: "mount"), "Mountain"),
        (UIImage(named: "beach"), "Beach"),
        (UIImage(named: "park"), "Park"),
        (UIImage(named: "cold"), "Arctic"),
        (UIImage(named: "safari"), "Desert"),
        (UIImage(named: "camping"), "Camping")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
        setupCards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(categoriesTitle)
        addSubview(cardsStack)
        
        categoriesTitle.text = viewModel.categoriesTitle
    }
    
    private func setupCards() {
        for category in categories {
            let card = CategoriesCardView()
            card.translatesAutoresizingMaskIntoConstraints = false
            
            card.configure(icon: category.icon, name: category.name)
            cardsStack.addArrangedSubview(card)
            
            NSLayoutConstraint.activate([
                card.widthAnchor.constraint(equalToConstant: 68),
                card.heightAnchor.constraint(equalToConstant: 93)
            ])
        }
    }
    
    private func setupConstrains() {
        categoriesTitle.translatesAutoresizingMaskIntoConstraints = false
        cardsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            categoriesTitle.topAnchor.constraint(equalTo: topAnchor),
            categoriesTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            cardsStack.topAnchor.constraint(equalTo: categoriesTitle.bottomAnchor, constant: 34),
            cardsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardsStack.heightAnchor.constraint(equalToConstant: 93),
            cardsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
