import UIKit

// Интерфейс основного координатор
protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var controller: UIViewController { get set }
    
    func start()
}

// Flow - координаторы. Определяют стеки UINavigationController

// Основной координатор, отвечает за UITabBarController
class AppCoordinator: Coordinator {
    var controller: UIViewController
    var childCoordinators: [Coordinator]
    
    init(controller: UIViewController, childCoordinators: [Coordinator] = []) {
        self.controller = controller
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        guard let tabBarController = controller as? UITabBarController else { return }
        var navigationControllers = [UINavigationController]()
        for coordinator in childCoordinators {
            navigationControllers.append(coordinator.controller as! UINavigationController)
            coordinator.start()
        }
        
        tabBarController.viewControllers = navigationControllers
    }
}
