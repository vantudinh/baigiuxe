//
//  UILabel+Extension.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

extension UILabel {
    func underlineLastCharacter() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: self.text&.count - 1, length: 1))
            self.attributedText = attributedString
        }
    }
}

