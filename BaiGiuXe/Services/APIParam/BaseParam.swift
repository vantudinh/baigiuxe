//
//  BaseParam.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import ObjectMapper

class BaseParam: NSObject, Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    override init() {
        
    }
    
//    public static func addDeviceParams(inputParams : Dictionary<String, Any>) -> Dictionary<String, Any> {
//        var params = inputParams;
//        if let appVersion = Bundle.main.infoDictionary?["CFBundleVersion"]  as? String {
//            params[Params.appVersion] =  appVersion
//        }
//
//        if let appId = Bundle.main.infoDictionary?["CFBundleIdentifier"]  as? String {
//            params[Params.appId] =  appId
//            params[Params.appName] =  appId
//        }
//
//        if let fcmToken = UserDefaultHelper.shared.fcmToken {
//             params[Params.appleToken]  = fcmToken
//        }
//
//        params[Params.deviceId] =  UIDevice.current.identifierForVendor!.uuidString
//        params[Params.phonecode] = "+84"
//        params[Params.timezone] = Utils.getTimeZone()
//
//        params[Params.deviceName] =  UIDevice.current.model
//        params[Params.deviceVersion] =  UIDevice.current.systemName + " " + UIDevice.current.systemVersion
//
//        return params
//    }
}





//protocol BaseParam {
//    func propertyIgnored() -> [String]
//}
//
//extension BaseParam {
//    func toHttpBodyString() -> [String: Any] {
//         var parameter: [String: Any] = [:]
//
//        let mirror = Mirror(reflecting: self)
//
//        for (labelMaybe, valueMaybe) in mirror.children {
//            if let label = labelMaybe {
//                if let valueConverted = self.valueFor(property: "some", of: valueMaybe) {
//                    if !propertyIgnored().contains(label) {
//                        parameter[label] = valueConverted
//                    }
//
//                } else {
//                    if !propertyIgnored().contains(label) {
//                        parameter[label] = valueMaybe
//                    }
//                }
//            }
//        }
//
//        return parameter
//
//    }
//
//    private func isNilDescendant(_ any: Any?) -> Bool {
//        return String(describing: any) == "Optional(nil)"
//    }
//
//    private func valueFor(property:String, of object:Any) -> Any? {
//        let mirror = Mirror(reflecting: object)
//        if let child = mirror.descendant(property), !isNilDescendant(child) {
//            return child
//        }
//        else if let _obj = object as? Bool {
//            let fakeOptional: Bool? = _obj
//            return fakeOptional
//        } else {
//            return nil
//        }
//    }
//}
