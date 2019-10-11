//
//  UISearchBar+extension.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/25/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

extension UISearchBar {
    func removeBackgroundImageView(){
        if let view:UIView = self.subviews.first {
            for curr in view.subviews {
                guard let searchBarBackgroundClass = NSClassFromString("UISearchBarBackground") else {
                    return
                }
                if curr.isKind(of:searchBarBackgroundClass){
                    if let imageView = curr as? UIImageView{
                        imageView.removeFromSuperview()
                        break
                    }
                }
            }
        }
    }
}
