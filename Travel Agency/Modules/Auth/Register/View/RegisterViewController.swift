import UIKit

class RegisterViewController: UIViewController {
    
    var viewModel: RegisterViewModelInputProtocol?
    
    private let regTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_SemiBold", size: 26)
        lbl.textColor = .textBlack
        return lbl
    }()
    
    private let regText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 16)
        lbl.textColor = .textGrey
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
    
    private let loginText: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 14)
        lbl.textColor = .textGrey
        return lbl
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setTitle("Sign in" , for: .normal)
        button.setTitleColor(.brandClr, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var footerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginText ,loginButton])
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
        NavigationHelper.push(LoginViewController(), from: self)
    }
    
    private func SetupActions() {
        loginButton.addTarget(self, action: #selector(getLogin), for: .touchUpInside)
        
        name.configure(placeholder: "Your name")
        password.configure(placeholder: "Your password")
        
        button.configure(title: "Sign up") { [weak self] in
            guard let self else { return }
                        
            viewModel?.registerDidTap(username: name.text, password: password.text)
        }
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(textStack)
        view.addSubview(fieldsStack)
        view.addSubview(navigationStack)
        
        regTitle.text = viewModel?.regTitle
        regText.text = viewModel?.regText
        loginText.text = viewModel?.loginText
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
