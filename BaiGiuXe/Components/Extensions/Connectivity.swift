//
//  File.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() {
        if !NetworkReachabilityManager()!.isReachable {
//            PopUpHelper.shared.showMessageHaveAds(message: "Vui lòng kết nối internet")
        }
    }
    
}
