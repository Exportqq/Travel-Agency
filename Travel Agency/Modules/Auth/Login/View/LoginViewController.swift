import UIKit

class LoginViewController: UIViewController {
    private let logTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_SemiBold", size: 26)
        lbl.textColor = .textBlack
        lbl.text = "Sign in now"
        return lbl
    }()
    
    private let logText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 16)
        lbl.textColor = .textGrey
        lbl.text = "Please sign in to continue our app"
        return lbl
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logTitle ,logText])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    let name = CustomTextField()
    let password = CustomTextField()

    let button = CustomButton()
    
    private let registerText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 14)
        lbl.textColor = .textGrey
        lbl.text = "Already have an account"
        return lbl
    }()
    
    private let registerButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setTitle("Sign up" , for: .normal)
        button.setTitleColor(.brandClr, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var footerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [registerText ,registerButton])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [name ,password])
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var navigationStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [button, footerStack])
        stack.axis = .vertical
        stack.spacing = 40
        stack.alignment = .center
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        SetupActions()
    }
    
    @objc private func getLogin() {
        NavigationHelper.pop(from: self)
    }
    
    @objc private func successLogin() {
        NavigationHelper.push(Profile(), from: self)
    }
    
    private func SetupActions() {
        registerButton.addTarget(self, action: #selector(getLogin), for: .touchUpInside)
        
        name.configure(placeholder: "Your name")
        password.configure(placeholder: "Your password")
        
        button.configure(title: "Sign in") { [weak self] in
            guard let self else { return }
                        
            Task {
                do {
                    
                    self.showLoader()
                    
                    let login = try await LoginManager.shared.login(
                        username: self.name.text ?? "",
                        password: self.password.text ?? ""
                    )
                    
                    self.hideLoader()
                    self.successLogin()
                    KeychainService.shared.saveToken(login.token)
    
                    print("Успешно", login.token)
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
        [textStack, fieldsStack, navigationStack, button].forEach{
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
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
