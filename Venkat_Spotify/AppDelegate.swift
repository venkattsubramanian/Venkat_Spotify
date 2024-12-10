//
//  AppDelegate.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        gotoMainScreens()
        return true
    }
    
    func gotoMainScreens() {
        setRootController(SearchViewController())
    }
    
    func setRootController(_ viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

