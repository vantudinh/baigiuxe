//
//  UICollectionView+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation
import UIKit
// MARK: Cell
extension UICollectionViewCell {
    
    static var className: String {
        return String(describing: self)
    }
    
    static var identifier: String {
        return self.className
    }
}

// MARK: Table
extension UICollectionView {
    
    // Cell
    func registerCollectionCell<T: UICollectionViewCell>(_: T.Type, fromNib: Bool = true) {
        if fromNib {
            self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueCollectionCell<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        
        return cell as! T
    }
    
}


