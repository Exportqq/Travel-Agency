import UIKit

final class MainTabBarController: UITabBarController {

    private let customTabBar = CustomTabBarView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isHidden = true
        setupTabs()
        setupCustomTabBar()
        
        customTabBar.backgroundColor = .white
    }

    private func setupTabs() {
        let profile = ProfileViewController()
        let map = MapViewController()

        viewControllers = [
            profile,
            map
        ]
    }

    private func setupCustomTabBar() {
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            customTabBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            customTabBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 90)
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

