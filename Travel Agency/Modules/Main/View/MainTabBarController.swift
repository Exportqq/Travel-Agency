import UIKit

final class MainTabBarController: UITabBarController {

    private let customTabBar = CustomTabBarView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isHidden = true
        setupTabs()
        setupCustomTabBar()
    }

    private func setupTabs() {
        let main = ProfileViewController()
        let profile = MapViewController()
        let map = MapViewController()
        let favorite = MapViewController()

        viewControllers = [
            main,
            profile,
            map,
            favorite
        ]
    }

    private func setupCustomTabBar() {
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            customTabBar.heightAnchor.constraint(equalToConstant: 65)
        ])

        customTabBar.layer.shadowColor = UIColor(red: 151/255, green: 151/255, blue: 150/255, alpha: 1).cgColor
        customTabBar.layer.shadowOpacity = 0.14
        customTabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        customTabBar.layer.shadowRadius = 15

        customTabBar.onSelect = { [weak self] index in
            self?.selectedIndex = index
        }
    }

}

