//
//  UIViewController+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//


import UIKit

extension UIViewController {
    
    static func initFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ : T.Type) -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib(self)
    }
    
    static func initFrom(storyboardName: String) -> Self {
        func instantiateFromStoryboard<T: UIViewController>(_ : T.Type) -> T {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        }
        
        return instantiateFromStoryboard(self)
    }
}

func enumCount<T: Hashable>(_: T.Type) -> Int {
    var i = 1
    while (withUnsafePointer(to: &i, {
        return $0.withMemoryRebound(to: T.self, capacity: 1, { return $0.pointee })
    }).hashValue != 0) {
        i += 1
    }
    return i
}

extension UIViewController {
    func push(controller: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool = true ) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func present(controller: UIViewController, animated: Bool = true) {
        self.present(controller, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool = true) {
        self.dismiss(animated: animated, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
