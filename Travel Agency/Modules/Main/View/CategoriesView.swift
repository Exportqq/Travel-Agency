import UIKit

class CategoriesView: UIView {
    
    private let viewModel = CategoriesViewViewModel()
    
    var onCategorySelected: ((String?) -> Void)?
    private var selectedCard: CategoriesCardView?
    
    private let categoriesTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Bold", size: 20)
        lbl.textColor = .black
        return lbl
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceHorizontal = true
        return scroll
    }()
    
    private let cardsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
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
        addSubview(scrollView)
        scrollView.addSubview(cardsStack)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 37)
        
        categoriesTitle.text = viewModel.categoriesTitle
    }
    
    private func setupCards() {
        for (index, category) in categories.enumerated() {
            let card = CategoriesCardView()
            card.translatesAutoresizingMaskIntoConstraints = false
            
            card.configure(icon: category.icon, name: category.name)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(categoryTapped(_:)))
            card.addGestureRecognizer(tap)
            card.isUserInteractionEnabled = true
            card.tag = index
            
            cardsStack.addArrangedSubview(card)
            
            NSLayoutConstraint.activate([
                card.widthAnchor.constraint(equalToConstant: 68),
                card.heightAnchor.constraint(equalToConstant: 93)
            ])
        }
    }
    
    @objc private func categoryTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedCard = sender.view as? CategoriesCardView else { return }
        
        let index = tappedCard.tag
        let selected = categories[index].name
        
        if selectedCard == tappedCard {
            tappedCard.setSelected(false)
            selectedCard = nil
            onCategorySelected?(nil)
            return
        }
        
        selectedCard?.setSelected(false)
        
        tappedCard.setSelected(true)
        selectedCard = tappedCard
        
        onCategorySelected?(selected)
    }
    
    private func setupConstrains() {
        categoriesTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        cardsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            categoriesTitle.topAnchor.constraint(equalTo: topAnchor),
            categoriesTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: categoriesTitle.bottomAnchor, constant: 34),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 93),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardsStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cardsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cardsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cardsStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            cardsStack.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
