import Foundation

protocol RegisterViewModelInputProtocol: AnyObject {
    var regTitle: String { get }
   
    func registerDidTap(username: String?, password: String?)
}

final class RegisterViewModel: RegisterViewModelInputProtocol {
    
    var regTitle: String = "Sign up now"
    
    func registerDidTap(username: String?, password: String?) {
        guard let username, let password else { return }
        
        Task {
            do {
                
//                self.showLoader()
                
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
