//
//  UIColor+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//


import UIKit

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String) {
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    //R:G:B:W
    func toRGB() -> String {
        var value = ""
        if let components = self.cgColor.components {
            if components.count > 3 {
                let red = Int(components[0] * 255).toIntPositive()
                let green = Int(components[1] * 255).toIntPositive()
                let blue = Int(components[2] * 255).toIntPositive()
                
                value = "\(red):\(green):\(blue)"
            } else if components.count == 2 {
                if components[0] == 1 {
                    value = "255:255:255"
                } else {
                    value = "0:0:0"
                }
            }
        }
       
        return value
    }
}

