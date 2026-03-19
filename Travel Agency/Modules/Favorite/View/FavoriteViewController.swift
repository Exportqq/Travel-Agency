import UIKit

class FavoriteViewController: UIViewController, UISearchBarDelegate {
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
    
    let avatarEmoji: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "memoji")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let favoriteCard = FavoriteCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    private func setupActions() {
        favoriteCard.configure(icon: UIImage(named: "testt"), name: "Test Location", geo: "Test Geo")
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(mainText)
        view.addSubview(avatarCircle)
        avatarCircle.addSubview(avatarEmoji)
        view.addSubview(favoriteCard)
    }
    
    private func SetupConstraints() {
        [mainText, avatarCircle, avatarEmoji, favoriteCard].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainText.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            mainText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            mainText.heightAnchor.constraint(equalToConstant: 40),
            
            avatarEmoji.centerYAnchor.constraint(equalTo: avatarCircle.centerYAnchor),
            avatarEmoji.centerXAnchor.constraint(equalTo: avatarCircle.centerXAnchor),
            
            avatarCircle.centerYAnchor.constraint(equalTo: mainText.centerYAnchor),
            avatarCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            avatarCircle.widthAnchor.constraint(equalToConstant: 70),
            avatarCircle.heightAnchor.constraint(equalToConstant: 70),
            
            favoriteCard.topAnchor.constraint(equalTo: avatarCircle.bottomAnchor, constant: 37),
            favoriteCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            favoriteCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            favoriteCard.heightAnchor.constraint(equalToConstant: 122)
        ])
    }
}
