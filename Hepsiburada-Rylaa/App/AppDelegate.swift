//
//  AppDelegate.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit
import Bagel
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) { } else {
            let navigationController = UINavigationController()
            let homeViewController = HomeRouter.createModule(using: navigationController)
            navigationController.pushViewController(homeViewController, animated: false)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window
            Bagel.start()
            theme.appTheme.setCustomBackButton()
        }
        return true
    }
    
}

