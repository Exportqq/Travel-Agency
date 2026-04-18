import UIKit

class Main: UIViewController, UISearchBarDelegate {
    private let mainTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 32)
        lbl.textColor = .black
        return lbl
    }()
    
    private let mainText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Bold", size: 32)
        lbl.textColor = .black
        return lbl
    }()
    
    private let avatarCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .avatarClr
        view.layer.cornerRadius = 35
        return view
    }()
    
    let avatarEmoji: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "memoji")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let mainPlaces: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Bold", size: 20)
        lbl.textColor = .black
        return lbl
    }()
    
    private let categories = CategoriesView()
    
    private lazy var search = CustomSearchBar(searchDelegate: self)
    
    let viewModel = MainViewControllerViewModel()
    
    private let placesController = PlacesCollectionView()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [categories])
        stack.axis = .vertical
        stack.spacing = 56
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupLocationSelection()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(mainTitle)
        view.addSubview(mainText)
        view.addSubview(avatarCircle)
        avatarCircle.addSubview(avatarEmoji)
        view.addSubview(search)
        view.addSubview(mainStack)
        view.addSubview(mainPlaces)
        
        addChild(placesController)
        view.addSubview(placesController.view)
        placesController.didMove(toParent: self)
        
        mainText.text = viewModel.mainText
        mainTitle.text = viewModel.mainTitle
        mainPlaces.text = viewModel.mainPlaces
    }
    
    private func SetupConstraints() {
        [mainTitle, mainText, avatarCircle, avatarEmoji, search, mainStack, mainPlaces].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        placesController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            mainTitle.heightAnchor.constraint(equalToConstant: 38),
            
            mainText.topAnchor.constraint(equalTo: mainTitle.bottomAnchor),
            mainText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            
            avatarEmoji.centerYAnchor.constraint(equalTo: avatarCircle.centerYAnchor),
            avatarEmoji.centerXAnchor.constraint(equalTo: avatarCircle.centerXAnchor),
            
            avatarCircle.topAnchor.constraint(equalTo: mainTitle.topAnchor),
            avatarCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            avatarCircle.widthAnchor.constraint(equalToConstant: 70),
            avatarCircle.heightAnchor.constraint(equalToConstant: 70),
            
            search.topAnchor.constraint(equalTo: mainText.bottomAnchor, constant: 28),
            search.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            search.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            search.heightAnchor.constraint(equalToConstant: 65),
            
            mainPlaces.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 56),
            mainPlaces.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            
            placesController.view.topAnchor.constraint(equalTo: mainPlaces.bottomAnchor, constant: 34),
            placesController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            placesController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placesController.view.heightAnchor.constraint(equalToConstant: 177),
            
            mainStack.topAnchor.constraint(equalTo: placesController.view.bottomAnchor, constant: 56),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            
        ])
    }
    
    private func setupLocationSelection() {
        placesController.onPlacesSelected = { [weak self] location in
            guard let self = self else { return }
            
            let vc = LocationDetailViewController()
            
            let baseUrl = "https://travel-qdi5.onrender.com"
            let fullUrl = baseUrl + (location.img ?? "")
            
            vc.configure(
                imageUrl: fullUrl,
                name: location.name ?? "",
                geo: location.country ?? "",
                placeId: location.id,
                isFavorite: location.isFavorite ?? false,
                placeUrl: location.link ?? "",
                adress: location.address ?? "",
                open_time: location.open_date ?? ""
            )
            
            NavigationHelper.push(vc, from: self)
        }
    }
    
}
