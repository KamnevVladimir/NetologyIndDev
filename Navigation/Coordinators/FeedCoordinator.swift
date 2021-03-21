import UIKit

protocol FeedFlowCoordinator: ChildCoordinator {
    func showPostVC(post: Post)
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
    
    func showPostVC(post: Post) {
        let postViewController = PostViewController()
        postViewController.coordinator = self
        postViewController.post = post
        
        navigationController.pushViewController(postViewController, animated: true)
    }
}
