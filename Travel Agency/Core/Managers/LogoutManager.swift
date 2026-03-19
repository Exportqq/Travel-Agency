import Foundation

final class LogoutManager {

    static let shared = LogoutManager()
    private init() {}

    func logout() {
        KeychainService.shared.deleteToken()
    }
}
