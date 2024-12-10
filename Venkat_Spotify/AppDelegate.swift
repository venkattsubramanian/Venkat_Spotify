//
//  AppDelegate.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setRootController(ViewController())
        return true
    }
    
    
}
extension AppDelegate{
    
    /// Sets the root view controller of the window.
    /// - Parameter viewController: The view controller to set as root.
    /// - Throws: An error if the window or root view controller couldn't be set up.
    func setRootController(_ viewController: UIViewController){
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

