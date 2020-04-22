//
//  ViewController.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    window = UIWindow(frame: UIScreen.main.bounds)
           window?.makeKeyAndVisible()
           window?.rootViewController = UINavigationController(rootViewController: TableView())
           
           let navigationBarAppearace = UINavigationBar.appearance()
           navigationBarAppearace.barTintColor = UIColor.red
           navigationBarAppearace.tintColor = UIColor.white
           navigationBarAppearace.isTranslucent = false
           navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
           return true
       }


}

