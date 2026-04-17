import UIKit
import Kingfisher

class LocationDetailViewController: UIViewController {
    
    var placeId: Int?
    var placeUrl: String?
    
    let bookBtn = CustomButton()
    let locationCircle = IconBubbleView()
    let openTimeCircle = IconBubbleView()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let favorite: UIButton = {
        let btn = UIButton(type: .custom)

        let icon = UIImageView()
        icon.image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .black
        icon.contentMode = .scaleAspectFit

        btn.addSubview(icon)

        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 18),
            icon.heightAnchor.constraint(equalToConstant: 18)
        ])

        btn.backgroundColor = .white
        btn.layer.cornerRadius = 22

        return btn
    }()
    
    private let backBtn: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "back_arrow")

        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 22

        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        return btn
    }()
    
    private let shareBtn: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "share")

        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 22

        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: 11, bottom: 12, right: 11)

        return btn
    }()
    
    let locationName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Bold", size: 32)
        lbl.textColor = .black
        return lbl
    }()
    
    let locationGeo: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Medium", size: 20)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationName, locationGeo])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    let locationCircleText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Medium", size: 9)
        lbl.textColor = .black
        return lbl
    }()
    
    let openTimeCircleText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Medium", size: 9)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationCircle, locationCircleText])
        stack.axis = .horizontal
        stack.spacing = 7
        stack.alignment = .center
        return stack
    }()
    
    private lazy var infoStackTwo: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [openTimeCircle, openTimeCircleText])
        stack.axis = .horizontal
        stack.spacing = 7
        stack.alignment = .center
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoStack, infoStackTwo])
        stack.axis = .vertical
        stack.spacing = 23
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scrollView.contentInsetAdjustmentBehavior = .never
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(locationImage)
        contentView.addSubview(favorite)
        contentView.addSubview(backBtn)
        contentView.addSubview(shareBtn)
        contentView.addSubview(textStack)
        contentView.addSubview(mainStack)
        
        view.addSubview(bookBtn)
    }
    
    private func SetupConstraints() {
        [scrollView, contentView, locationImage, favorite, backBtn, shareBtn, textStack, mainStack, bookBtn].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bookBtn.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            locationImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            locationImage.heightAnchor.constraint(equalToConstant: 473),
            locationImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            
            backBtn.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 18),
            backBtn.leadingAnchor.constraint(equalTo: locationImage.leadingAnchor, constant: 16),
            backBtn.heightAnchor.constraint(equalToConstant: 42),
            backBtn.widthAnchor.constraint(equalToConstant: 42),
            
            shareBtn.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 18),
            shareBtn.trailingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: -63),
            shareBtn.heightAnchor.constraint(equalToConstant: 42),
            shareBtn.widthAnchor.constraint(equalToConstant: 42),
            
            favorite.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 18),
            favorite.trailingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: -16),
            favorite.heightAnchor.constraint(equalToConstant: 42),
            favorite.widthAnchor.constraint(equalToConstant: 42),
            
            textStack.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 50),
            textStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            mainStack.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            locationCircle.widthAnchor.constraint(equalToConstant: 42),
            locationCircle.heightAnchor.constraint(equalToConstant: 42),
            
            openTimeCircle.widthAnchor.constraint(equalToConstant: 42),
            openTimeCircle.heightAnchor.constraint(equalToConstant: 42),
            
            bookBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            bookBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bookBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bookBtn.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    @objc private func shareTapped() {
        guard let placeUrl,
              let url = URL(string: placeUrl) else {
            return
        }

        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = shareBtn
            popover.sourceRect = shareBtn.bounds
        }

        present(activityVC, animated: true)
    }
    
    private func setupActions() {
        backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        shareBtn.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        
        bookBtn.configure(title: "Book now") { [weak self] in
            self?.showAlert()
        }
    }
    
    func configure(imageUrl: String, name: String, geo: String, placeId: Int, isFavorite: Bool, placeUrl: String, adress: String, open_time: String) {
        self.placeId = placeId
        self.isFavorite = isFavorite
        self.placeUrl = placeUrl
        locationName.text = name
        locationGeo.text = geo
        locationCircleText.text = adress
        openTimeCircleText.text = "OPEN\n\(open_time)"
        
        if let url = URL(string: imageUrl) {
            locationImage.kf.setImage(with: url)
        }
        
        locationCircle.configure(icon: "location")
        openTimeCircle.configure(icon: "time")
    }
    
    private func updateFavoriteUI() {
        favorite.tintColor = isFavorite ? .red : .lightGray
    }
    
    @objc private func goBack() {
        NavigationHelper.pop(from: self)
    }
    
    private var isFavorite = false {
        didSet {
            updateFavoriteUI()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Hello 👋",
            message: "BOOOOOOOOOOOOK",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}
