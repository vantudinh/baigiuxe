//
//  Double+extension.swift
//  RedStar
//
//  Created by Ngoc Duong on 12/9/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

extension Double {
    func toStringBillion() -> String {
        let intSelf = Int(self)
        let intBillion = intSelf / 1000
        let modMillion = intSelf % 1000
        let intMillion = modMillion / 100
        
        if intBillion == 0 {
            return "\(intSelf) triệu"
        } else {
            if modMillion == 0 || modMillion < 100 {
                return "\(intBillion) tỷ"
            } else {
                return "\(intBillion).\(intMillion) tỷ"
            }
        }
    }
}
