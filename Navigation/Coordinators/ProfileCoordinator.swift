import UIKit

protocol ProfileFlowCoordinator: ChildCoordinator {
    func showProfileVC()
    func showPhotosVC()
}

class ProfileCoordinator: ProfileFlowCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        loginViewController.tabBarItem = TabBarModel.items[.profile]
        
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func showProfileVC() {
        let profileViewController = ProfileViewController()
        profileViewController.coordinator = self

        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func showPhotosVC() {
        let photosProfileViewController = PhotosViewController()
        photosProfileViewController.coordinator = self
        photosProfileViewController.output = PhotosViewModel()
        
        navigationController.pushViewController(photosProfileViewController, animated: true)
    }
}
