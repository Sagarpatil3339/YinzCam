//
//  AppDelegate.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit
/*
 Programatically assigning navigation bar and preparing root view controller
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TableView())
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = UIColor(red: 20/255.0, green: 79/255.0, blue: 89/255.0, alpha: 1.0)
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.isTranslucent = false
        if let font = UIFont(name: Constants.LeagueGothicRegularFont, size: 20) {
            navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.font:font]
        }
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        return true
    }
}

