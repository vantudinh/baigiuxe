//
//  Bool+extension.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

extension Bool {
    func toString() -> String {
        return self == true ? "ON": "OFF"
    }
}

