//
//  AppDelegate.swift
//  4K-SOFT_Test_Task
//
//  Created by Vitaliy Griza on 08.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var NVC : UINavigationController!

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    NVC = NavigationVC(rootViewController: ViewController())
    window?.rootViewController = NVC
    window?.makeKeyAndVisible()
    
    return true
}
}

