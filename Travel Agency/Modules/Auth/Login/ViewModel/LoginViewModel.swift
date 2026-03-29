import Foundation

protocol LoginViewModelInputProtocol: AnyObject {
    var logTitle: String { get }
    var logText: String { get }
    var registerText: String { get }
    
    var onLoginSuccess: (() -> Void)? { get set }
    
    func loginDidTap(username: String?, password: String?)
}

final class LoginViewModel: LoginViewModelInputProtocol {
    
    var logTitle: String = "Sign in now"
    var logText: String = "Please sign in to continue our app"
    var registerText: String = "Already have an account"
    
    var onLoginSuccess: (() -> Void)?
    
    func loginDidTap(username: String?, password: String?) {
        guard let username, let password else { return }
        
        Task {
            do {
                let login = try await LoginManager.shared.login(
                    username: username,
                    password: password
                )
                
                KeychainService.shared.saveToken(login.token)
                print("Успешно", login.token)
                
                await MainActor.run {
                    self.onLoginSuccess?()
                }
                
            } catch {
                print("Ошибка авторизации")
            }
        }
    }
}
