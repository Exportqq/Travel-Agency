import UIKit

final class CustomTabBarView: UIView {

    var onSelect: ((Int) -> Void)?

    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        backgroundColor = .white

        let homeBtn = makeButton(image: "main", tag: 0)
        let profileBtn = makeButton(image: "profile", tag: 1)
        let mapBtn = makeButton(image: "map", tag: 2)
        let favoriteBtn = makeButton(image: "favorite", tag: 3)


        buttons = [homeBtn, profileBtn, mapBtn, favoriteBtn]

        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 80
        stack.translatesAutoresizingMaskIntoConstraints = false
        

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        select(index: 0)
    }

    private func makeButton(image: String, tag: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(
            UIImage(named: image)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        btn.tintColor = .lightGray
        btn.tag = tag

        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 32),
            btn.heightAnchor.constraint(equalToConstant: 32)
        ])

        btn.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
        return btn
    }

    @objc private func tap(_ sender: UIButton) {
        select(index: sender.tag)
        onSelect?(sender.tag)
    }

    func select(index: Int) {
        selectedIndex = index

        for (i, btn) in buttons.enumerated() {
            btn.tintColor = i == index ? .systemIndigo : .lightGray
        }
    }
}
