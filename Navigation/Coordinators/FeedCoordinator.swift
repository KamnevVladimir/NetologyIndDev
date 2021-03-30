import UIKit

protocol FeedFlowCoordinator: Coordinator {
    func showPostVC(post: Post)
}

class FeedCoordinator: FeedFlowCoordinator {
    var controller: UIViewController
    var childCoordinators: [Coordinator]
    
    init(controller: UIViewController, childCoordinators: [Coordinator] = []) {
        self.controller = controller
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        guard let navigationController = controller as? UINavigationController else { return }
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        feedViewController.tabBarItem = TabBarModel.items[.feed]
        
        navigationController.pushViewController(feedViewController, animated: false)
    }
    
    func showPostVC(post: Post) {
        guard let navigationController = controller as? UINavigationController else { return }
        let postViewController = PostViewController()
        postViewController.coordinator = self
        postViewController.post = post
        
        navigationController.pushViewController(postViewController, animated: true)
    }
}
