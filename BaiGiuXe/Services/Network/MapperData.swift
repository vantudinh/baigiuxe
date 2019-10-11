//
//  MapperData.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

struct MapperData {
    // MARK: MAP IOT
//    static func mapIot<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkSuccess {
//        return { baseResponse in
//            let json = baseResponse.data&.toDictionary()
//            let obj = Mapper<T>().map(JSONObject: json)
//            successHandler(obj)
//        }
//    }
    
    // MARK: MAP JSON OBJECT
    static func mapObject<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkSuccess {
        return { baseResponse in
//            let json = baseResponse.message&.toDictionary()
            let obj = Mapper<T>().map(JSONObject: baseResponse.data)
            successHandler(obj)
        }
    }
    
    static func mapArray<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.array) -> NetworkSuccess {
        return { baseResponse in
            let obj = Mapper<T>().mapArray(JSONObject: baseResponse.data)
            successHandler(obj!)
        }
    }
    
    static func mapNoData<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkSuccess {
        return { baseResponse in
            let objResult = Mapper<T>().map(JSONObject: baseResponse.toJSON())
           
            successHandler(objResult)
        }
    }
}
