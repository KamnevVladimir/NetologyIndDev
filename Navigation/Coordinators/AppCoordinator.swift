import UIKit

// Интерфейс основного координатор
protocol BaseCoordinator: class {
    var childCoordinators: [ChildCoordinator] { get set }
    var tabBarController: UITabBarController { get set }
    
    func start()
}

// Flow - координаторы. Определяют стеки UINavigationController
protocol ChildCoordinator: class {
    var navigationController: UINavigationController { get set }
    
    func start()
}

// Основной координатор, отвечает за UITabBarController
class AppCoordinator: BaseCoordinator {
    var tabBarController: UITabBarController
    var childCoordinators: [ChildCoordinator]
    
    init(tabBarController: UITabBarController, childCoordinators: [ChildCoordinator] = []) {
        self.tabBarController = tabBarController
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        var navigationControllers = [UINavigationController]()
        for coordinator in childCoordinators {
            navigationControllers.append(coordinator.navigationController)
        }
        
        tabBarController.viewControllers = navigationControllers
    }
    
}
