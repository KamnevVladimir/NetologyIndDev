import UIKit

class FeedCoordinator: ChildCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        
        navigationController.pushViewController(feedViewController, animated: false)
    }
    
    
}
