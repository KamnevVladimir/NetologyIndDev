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
        let controller = LoginViewController()
        controller.coordinator = self
        controller.tabBarItem = TabBarModel.items[.profile]
        
        navigationController.pushViewController(controller, animated: false)
    }
    
    func showProfileVC() {
        let viewModel = ProfileViewModel()
        let controller = ProfileViewController(viewModel: viewModel)
        controller.coordinator = self
        viewModel.viewInput = controller
        viewModel.onCellTap = { [weak self] in
            guard let self = self else { return }
            self.showPhotosVC()
        }
        

        navigationController.pushViewController(controller, animated: true)
    }
    
    func showPhotosVC() {
        let viewModel = PhotosViewModel()
        let controller = PhotosViewController(viewModel: viewModel)
        controller.coordinator = self
        
        navigationController.pushViewController(controller, animated: true)
    }
}
