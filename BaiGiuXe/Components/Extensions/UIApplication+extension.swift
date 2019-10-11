//
//  UIApplication.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
extension UIApplication {
    
    static var rootVC: UINavigationController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
