//
//  BaseResponse.swift
//  Cihyn_Dev
//
//  Created by Ngoc Duong on 9/28/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import ObjectMapper

// Base
class BaseResponse: Mappable {
    var status: Int?
    var message: String?
    var data: Any?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        status      <- map["status"]
        message     <- map["message"]
        data        <- map["data"]
    }
}

class BaseResponseString: Mappable {
    var status: Int?
    var message: String?
    var data: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        status      <- map["code"]
        message     <- map["message"]
        data        <- map["data"]
    }
}

