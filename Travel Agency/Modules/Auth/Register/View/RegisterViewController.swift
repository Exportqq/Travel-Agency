import UIKit

class RegisterViewController: UIViewController {
    private let regTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-SemiBold", size: 26)
        lbl.textColor = .textBlack
        lbl.text = "Sign up now"
        return lbl
    }()
    
    private let regText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 16)
        lbl.textColor = .textGrey
        lbl.text = "Please fill the details and create account"
        return lbl
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [regTitle ,regText])
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        
        print("open")
    }
    
    private func SetupView() {
        view.backgroundColor = .red
        
        view.addSubview(textStack)
    }
    
    private func SetupConstraints() {
        [textStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            textStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
