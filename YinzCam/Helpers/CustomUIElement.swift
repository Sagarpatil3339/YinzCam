//
//  UIElementSizes.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

/* For customising different UI Elements and assigning values to their properties*/

class CustomUIElement {

    // Screen window size in terms of variables for height and width
    static var windowWidth: CGFloat = UIScreen.main.bounds.width
    static var windowHeight: CGFloat = UIScreen.main.bounds.height
    
    // For customising UILabel's attributes
    static func forLabel(sender: UILabel,name: String, size: CGFloat, rgbValues: (CGFloat?, CGFloat?, CGFloat?) = (0,0,0), textAlignment: NSTextAlignment? = .left){
        sender.font = UIFont(name: name, size: size)
        sender.adjustsFontSizeToFitWidth = true;
        sender.textColor = UIColor(red: rgbValues.0!/255.0, green: rgbValues.1!/255.0, blue: rgbValues.2!/255.0, alpha: 1.0)
        sender.textAlignment = textAlignment!
    }
}
