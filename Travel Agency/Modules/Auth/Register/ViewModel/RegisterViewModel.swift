import Foundation

protocol RegisterViewModelInputProtocol: AnyObject {
    var regTitle: String { get }
    var regText: String { get }
    var loginText: String { get }
    
    var onRegisterSuccess: (() -> Void)? { get set }
    var onLoadingStateChange: ((Bool) -> Void)? { get set }
   
    func registerDidTap(username: String?, password: String?)
}

final class RegisterViewModel: RegisterViewModelInputProtocol {
    
    var regTitle: String = "Sign up now"
    var regText: String = "Please fill the details and create account"
    var loginText: String = "Already have an account"
    
    var onRegisterSuccess: (() -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    
    func registerDidTap(username: String?, password: String?) {
        guard let username, let password else { return }
        
        onLoadingStateChange?(true)
        
        Task {
            do {
                                
                try await RegisterManager.shared.register(
                    username: username,
                    password: password
                )
                
                await MainActor.run {
                    self.onLoadingStateChange?(false)
                    self.onRegisterSuccess?()
                }
                
                print("Успешно")
            } catch {
                await MainActor.run {
                    self.onLoadingStateChange?(false)
                }
                print("Ошибка ргестирации")
            }
        }
    }
    
}
