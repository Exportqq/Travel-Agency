import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModelInputProtocol?
    
    private let logTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_SemiBold", size: 26)
        lbl.textColor = .textBlack
        return lbl
    }()
    
    private let logTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 16)
        lbl.textColor = .textGrey
        return lbl
    }()
    
    private let registerTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular", size: 14)
        lbl.textColor = .textGrey
        return lbl
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign up", for: .normal)
        btn.setTitleColor(.brandClr, for: .normal)
        btn.backgroundColor = .clear
        btn.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        return btn
    }()
    
    private let nameField = CustomTextField()
    private let passwordField = CustomTextField()
    private let loginButton = CustomButton()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logTitleLabel, logTextLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField, passwordField])
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var footerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [registerTextLabel, registerButton])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    private lazy var navigationStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginButton, footerStack])
        stack.axis = .vertical
        stack.spacing = 40
        stack.alignment = .center
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupActions()
        setupBindings()
    }
    
    private func setupViews() {
        view.addSubview(textStack)
        view.addSubview(fieldsStack)
        view.addSubview(navigationStack)
        
        logTitleLabel.text = viewModel?.logTitle
        logTextLabel.text = viewModel?.logText
        registerTextLabel.text = viewModel?.registerText
        
        nameField.configure(placeholder: "Your name")
        passwordField.configure(placeholder: "Your password")
        
        loginButton.configure(title: "Sign in") { [weak self] in
            guard let self = self else { return }
            self.viewModel?.loginDidTap(username: self.nameField.text, password: self.passwordField.text)
        }
    }
    
    private func setupConstraints() {
        [textStack, fieldsStack, navigationStack, loginButton].forEach {
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
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        registerButton.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        
        loginButton.configure(title: "Sign in") { [weak self] in
            guard let self = self else { return }
            self.viewModel?.loginDidTap(username: self.nameField.text, password: self.passwordField.text)
        }
    }
    
    private func setupBindings() {
        viewModel?.onLoginSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.successLogin()
            }
        }
    }
    
    @objc private func goToRegister() {
        NavigationHelper.pop(from: self)
    }
    
    private func successLogin() {
        NavigationHelper.push(TabBarController(), from: self)
    }
}
