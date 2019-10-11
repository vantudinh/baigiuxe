//
//  UIButton+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//


import UIKit

extension UIButton {
    func setAttributed(title: String, color: UIColor, font: UIFont?, isUnderLine: Bool = false ) {
        var attr = NSAttributedString()
        if isUnderLine {
            attr = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font!, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        } else {
            attr = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font!])
        }
        self.setAttributedTitle(attr, for: .normal)
    }
    
    func setAnimationTouch() {
        UIButton.animate(withDuration: 0.2,animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { finish in
            UIButton.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
    
}

extension UIButton {
    func setTitle(text: String, font: UIFont, color: UIColor, textUnderline: String, fontLine: UIFont, colorLine: UIColor) {
        let formattedText = NSMutableAttributedString()
        formattedText.normalText(text, font: font, color: color).underlineText(textUnderline, font: fontLine, color: colorLine)
        self.setAttributedTitle(formattedText, for: .normal)
    }
    
    func setTitle(text: String, font: UIFont, color: UIColor) {
        let formattedText = NSMutableAttributedString()
        formattedText.normalText(text, font: font, color: color)
        self.setAttributedTitle(formattedText, for: .normal)
    }
    
    func setTitleUnderLine(text: String, font: UIFont, color: UIColor) {
        let formattedText = NSMutableAttributedString()
        formattedText.underlineText(text, font: font, color: color)
        self.setAttributedTitle(formattedText, for: .normal)
    }
}
