import UIKit

class FeedCoordinator: ChildCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    
}
