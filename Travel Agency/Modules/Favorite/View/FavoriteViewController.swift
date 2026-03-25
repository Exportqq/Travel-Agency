import UIKit

class FavoriteViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    private var places: [MainModel] = []
    
    private let mainText: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your Favorite"
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
    
    private let avatarEmoji: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "memoji")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 9
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(LocationCell.self, forCellWithReuseIdentifier: "LocationCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        fetchFavorites()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(mainText)
        view.addSubview(avatarCircle)
        avatarCircle.addSubview(avatarEmoji)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        [mainText, avatarCircle, avatarEmoji, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            avatarCircle.centerYAnchor.constraint(equalTo: mainText.centerYAnchor),
            avatarCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            avatarCircle.widthAnchor.constraint(equalToConstant: 70),
            avatarCircle.heightAnchor.constraint(equalToConstant: 70),
            
            avatarEmoji.centerXAnchor.constraint(equalTo: avatarCircle.centerXAnchor),
            avatarEmoji.centerYAnchor.constraint(equalTo: avatarCircle.centerYAnchor),
            avatarEmoji.widthAnchor.constraint(equalToConstant: 60),
            avatarEmoji.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: mainText.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 132)
        ])
    }
    
    // MARK: - Fetch Favorites
    
    private func fetchFavorites() {
        Task {
            do {
                let data = try await viewModel.fetchPlaces()
                
                print("ВСЕ ДАННЫЕ:", data.count)
                
                let favorites = data.filter { $0.is_favorite == true }
                
                print("ИЗБРАННЫЕ:", favorites.count)
                
                DispatchQueue.main.async {
                    self.places = favorites
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("Error:", error)
            }
        }
    }
}

// MARK: - CollectionView

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        let place = places[indexPath.item]
        
        let baseUrl = "https://travel-qdi5.onrender.com"
        let fullUrl = baseUrl + (place.img ?? "")
        
        cell.card.configure(
            imageUrl: fullUrl,
            name: place.name ?? ""
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 40 // 20 слева и справа
        return CGSize(width: width, height: 132)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
