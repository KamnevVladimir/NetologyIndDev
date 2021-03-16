import UIKit

enum AuthResults {
    case loginIsValid
    case passwordIsValid
    case isValid
    case isInvalid
}

struct AuthChecker {
    static let shared = AuthChecker()
    
    private let login = "Vladimir"
    private let password = "Netology"
    
    private init () {
    }
    
    func authCheck(login: String = "", password: String = "") -> AuthResults {
        switch (login, password) {
        case ("", self.password):
            return AuthResults.passwordIsValid
        case (self.login, ""):
            return AuthResults.loginIsValid
        case (self.login, self.password):
            return AuthResults.isValid
        default:
            return AuthResults.isInvalid
        }
    }
}
