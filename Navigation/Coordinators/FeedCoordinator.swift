import UIKit

protocol FeedFlowCoordinator: ChildCoordinator {
    func showPostVC()
    func showInfoVC()
}

class FeedCoordinator: FeedFlowCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        
        navigationController.pushViewController(feedViewController, animated: false)
    }
    
    func showPostVC() {
        let postViewController = PostViewController()
        postViewController.coordinator = self
        
        navigationController.pushViewController(postViewController, animated: true)
    }
    
    func showInfoVC() {
        let infoViewController = InfoViewController()
        infoViewController.coordinator = self
        
        navigationController.pushViewController(infoViewController, animated: true)
    }

    
}
