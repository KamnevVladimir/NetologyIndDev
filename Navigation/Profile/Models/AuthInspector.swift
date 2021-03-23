import UIKit

struct AuthInspector: LoginViewControllerDelegate {
    func checkLogin(controller: LoginViewController, login: String) -> Bool {
        guard AuthChecker.shared.authCheck(login: login) == AuthResults.loginIsValid else { return false }
        return true
    }
    
    func checkPassword(controller: LoginViewController, password: String) -> Bool {
        guard AuthChecker.shared.authCheck(password: password) == AuthResults.passwordIsValid else { return false }
        return true
    }
}
