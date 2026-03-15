import UIKit

class CustomSearchBar: UIView {

    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Discover city"
        sb.searchBarStyle = .minimal
        sb.backgroundImage = UIImage()
        sb.backgroundColor = .searchClr
        sb.layer.cornerRadius = 25
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    init(searchDelegate: UISearchBarDelegate) {
        super.init(frame: .zero)

        searchBar.delegate = searchDelegate
        setupView()
        setupConstraints()
        customize()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(searchBar)
    
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func customize() {
        guard let textField = searchBar.searchTextField as UITextField? else { return }

        textField.backgroundColor = .searchClr
        textField.borderStyle = .none
        textField.clearButtonMode = .never
        textField.textColor = .textGrey

        let icon = UIImage(named: "search")
        textField.attributedPlaceholder = NSAttributedString(
            string: "Discover city",
            attributes: [
                .foregroundColor: UIColor(
                    red: 121/255,
                    green: 121/255,
                    blue: 121/255,
                    alpha: 1.0
                )
            ]
        )
        let iconView = UIImageView(image: icon)
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

        textField.leftView = iconView
        textField.leftViewMode = .always
    }
}
