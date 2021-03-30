import UIKit

protocol ProfileFlowCoordinator: Coordinator {
    func showProfileVC()
    func showPhotosVC()
    func popVC()
}

class ProfileCoordinator: ProfileFlowCoordinator {
    var controller: UIViewController
    var childCoordinators: [Coordinator]
    
    init(controller: UIViewController, childCoordinators: [Coordinator] = []) {
        self.controller = controller
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        guard let navigationController = controller as? UINavigationController else { return }
        let viewController = LoginViewController()
        viewController.coordinator = self
        viewController.tabBarItem = TabBarModel.items[.profile]
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showProfileVC() {
        guard let navigationController = controller as? UINavigationController else { return }
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        viewController.coordinator = self
        viewModel.viewInput = viewController
        viewModel.onCellTap = { [weak self] in
            guard let self = self else { return }
            self.showPhotosVC()
        }
        

        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showPhotosVC() {
        guard let navigationController = controller as? UINavigationController else { return }
        let viewModel = PhotosViewModel()
        let viewController = PhotosViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popVC() {
        guard let navigationController = controller as? UINavigationController else { return }
        navigationController.popViewController(animated: true)
    }
}
