import Foundation

protocol RegisterViewModelInputProtocol: AnyObject {
    var regTitle: String { get }
    var regText: String { get }
    var loginText: String { get }
   
    func registerDidTap(username: String?, password: String?)
}

final class RegisterViewModel: RegisterViewModelInputProtocol {
    
    var regTitle: String = "Sign up now"
    var regText: String = "Please fill the details and create account"
    var loginText: String = "Don’t have an account?"
    
    func registerDidTap(username: String?, password: String?) {
        guard let username, let password else { return }
        
        Task {
            do {
                
//                viewModel.showLoader()
                
                try await RegisterManager.shared.register(
                    username: username,
                    password: password
                )
                
//                self.hideLoader()
                
                
                print("Успешно")
            } catch {
                print("Ошибка ргестирации")
            }
        }
    }
    
}
