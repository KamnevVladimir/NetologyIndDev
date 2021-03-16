//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
        let loginNavigationController = UINavigationController(rootViewController: LoginViewController())
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedNavigationController, loginNavigationController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        // Setup title and icons within UITabBarController
        tabBarController.tabBar.items?[0].image = #imageLiteral(resourceName: "home-page")
        tabBarController.tabBar.items?[0].title = "Feed"
        tabBarController.tabBar.items?[1].image = #imageLiteral(resourceName: "user")
        tabBarController.tabBar.items?[1].title = "Profile"
        
        if let tabBarController = window?.rootViewController as? UITabBarController, let loginNavigationController = tabBarController.viewControllers?.last as? UINavigationController, let loginViewController = loginNavigationController.viewControllers.first as? LoginViewController {
            loginViewController.delegate = AuthInspector()
        }
        
        return true
    }

}

