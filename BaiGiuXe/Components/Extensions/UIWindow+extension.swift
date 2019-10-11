//
//  UIWindow+extension.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func showFromRight(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: CATransitionSubtype.fromRight.rawValue)
    }
    
    func showFromLeft(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: CATransitionSubtype.fromLeft.rawValue)
    }
    
    func showFromBottom(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: CATransitionSubtype.fromBottom.rawValue)
    }
    
    func showFromTop(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: CATransitionSubtype.fromTop.rawValue)
    }
    
    private func show(rootViewController: UIViewController, animated: Bool, animationType: String) {
        
        DispatchQueue.main.async {
            if animated {
                let animation               = CATransition()
                animation.timingFunction    = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                animation.type              = CATransitionType.push
                animation.subtype           = CATransitionSubtype(rawValue: animationType)
                animation.duration          = 0.4
                self.layer.add(animation, forKey: "transitionViewAnimation")
            } else {
                self.layer.removeAllAnimations()
            }
            self.rootViewController = rootViewController
            self.makeKeyAndVisible()
        }
    }
}
