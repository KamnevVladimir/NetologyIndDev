import Foundation

enum LoginErrors: Error {
    case invalidLogin
    case invalidPassword
    case invalidAuth
}

struct User {
    let login: String
    let password: String
    
    private static let succesLogin = "Vladimir"
    private static let successPassword = "12345"
    
    static func asyncAuth(login: String, password: String, completion: (Result<User, LoginErrors>) -> Void) {
        if login == succesLogin && password == successPassword {
            completion(.success(User(login: login, password: password)))
        } else if login == succesLogin && password != successPassword {
            completion(.failure(.invalidPassword))
        } else if login != succesLogin && password == successPassword {
            completion(.failure(.invalidLogin))
        } else {
            completion(.failure(.invalidAuth))
        }
    }
}
