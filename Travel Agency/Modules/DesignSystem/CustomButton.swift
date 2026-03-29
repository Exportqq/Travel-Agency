import UIKit

class CustomButton: UIView {
    
    private let сustomBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .brandClr
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    private var nextPageAction: (() -> Void)?

    @objc private func getNextPage() {
        nextPageAction?()
    }

    func configure(title: String, nextPage: @escaping () -> Void) {
        сustomBtn.setTitle(title, for: .normal)
        nextPageAction = nextPage
        сustomBtn.addTarget(self, action: #selector(getNextPage), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(сustomBtn)
    }
    
    
    private func setupConstrains() {
        [сustomBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            сustomBtn.topAnchor.constraint(equalTo: self.topAnchor),
            сustomBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            сustomBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            сustomBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            сustomBtn.heightAnchor.constraint(equalToConstant: 56),

        ])
    }
}

