import UIKit

class Main: UIViewController, UISearchBarDelegate {
    private let mainTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Where do"
        lbl.font = UIFont(name: "Inter-Regular", size: 32)
        lbl.textColor = .black
        return lbl
    }()
    
    private let mainText: UILabel = {
        let lbl = UILabel()
        lbl.text = "you want to go?"
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
    
    
    private lazy var search = CustomSearchBar(searchDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(mainTitle)
        view.addSubview(mainText)
        view.addSubview(avatarCircle)
        avatarCircle.addSubview(avatarEmoji)
        view.addSubview(search)
    }
    
    private func SetupConstraints() {
        [mainTitle, mainText, avatarCircle, avatarEmoji, search].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
            search.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
