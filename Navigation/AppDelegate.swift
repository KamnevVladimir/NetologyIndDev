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
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var timer: Timer?
    var timerCount = 0.0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(type(of: self), #function)
        
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
        let profileNavigationController = UINavigationController(rootViewController: LoginViewController())
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        // Setup title and icons within UITabBarController
        tabBarController.tabBar.items?[0].image = #imageLiteral(resourceName: "home-page")
        tabBarController.tabBar.items?[0].title = "Feed"
        tabBarController.tabBar.items?[1].image = #imageLiteral(resourceName: "user")
        tabBarController.tabBar.items?[1].title = "Profile"
        
        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(type(of: self), #function)
        registerBackgroundTask()
        
        /*
         Время работы приложения в BackgroundMode около 25.2 секунд
         */
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        assert(backgroundTask != .invalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        print("Время работы в Background = ", timerCount)
        timer?.invalidate()
        timerCount = 0
        
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    @objc private func updateTimer() {
        timerCount += timer!.timeInterval
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationSignificantTimeChange(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        print(type(of: self), #function)
    }
    
    
    func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(type(of: self), #function)
    }
    
    
    func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        print(type(of: self), #function)
    }
    
    
    func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(type(of: self), #function)
    }

    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?, reply: @escaping ([AnyHashable : Any]?) -> Void) {
        print(type(of: self), #function)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(type(of: self), #function)
    }
}

