import UIKit

struct AuthChecker {
    static let shared = AuthChecker()
    
    let login = "Vladimir"
    let password = "Netology"
    
    private init () {
    }
    
    func authCheck(login: String, password: String) -> Bool {
        guard login == self.login && password == self.password else { return false }
        return true
    }
}
