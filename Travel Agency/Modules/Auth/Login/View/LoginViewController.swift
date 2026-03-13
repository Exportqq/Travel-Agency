import UIKit

class LoginViewController: UIViewController {
    private let regTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_SemiBold", size: 26)
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
        stack.alignment = .center
        return stack
    }()
    
    let name = CustomTextField()
    let password = CustomTextField()

    let button = CustomButton()
    
    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [name ,password])
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .center
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var navigationStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [button])
        stack.axis = .vertical
        stack.spacing = 40
        stack.alignment = .center
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        SetipActions()
        
    }
    
    private func SetipActions() {
        name.configure(placeholder: "Your name")
        password.configure(placeholder: "Your password")
        
        button.configure(title: "Sign in") { [weak self] in
            guard let self else { return }
            
            print("click")
            
            Task {
                do {
                    print("Успешно")
                    
                    
                } catch {
                    print("Ошибка авторизации")
                }
            }
        }
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(textStack)
        view.addSubview(fieldsStack)
        view.addSubview(navigationStack)
    }
    
    private func SetupConstraints() {
        [textStack, fieldsStack, navigationStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            textStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fieldsStack.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 40),
            fieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            navigationStack.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 72),
            navigationStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            navigationStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
