import Foundation

protocol LoginViewModelInputProtocol: AnyObject {
    var logTitle: String { get }
    var logText: String { get }
    var registerText: String { get }
    
    var onLoginSuccess: (() -> Void)? { get set }
    var onLoadingStateChange: ((Bool) -> Void)? { get set }

    
    func loginDidTap(username: String?, password: String?)
}

final class LoginViewModel: LoginViewModelInputProtocol {
    
    var logTitle: String = "Sign in now"
    var logText: String = "Please sign in to continue our app"
    var registerText: String = "Don’t have an account?"
    
    var onLoginSuccess: (() -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    
    func loginDidTap(username: String?, password: String?) {
        guard let username, let password else { return }
        
        onLoadingStateChange?(true)
        
        Task {
            do {
                                
                let login = try await LoginManager.shared.login(
                    username: username,
                    password: password
                )
                
                KeychainService.shared.saveToken(login.token)
                print("Успешно", login.token)
                
                await MainActor.run {
                    self.onLoadingStateChange?(false)
                    self.onLoginSuccess?()
                }
                
            } catch {
                await MainActor.run {
                    self.onLoadingStateChange?(false)
                }
                print("Ошибка авторизации")
            }
        }
    }
}
