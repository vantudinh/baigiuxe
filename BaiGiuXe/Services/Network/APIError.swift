//
//  APIError.swift
//  Cihyn_Dev
//
//  Created by Ngoc Duong on 9/28/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit

// MARK APPError
struct APPError {
    static let canNotParseData = APIError(message: "Can Not Parse Data")
}

// MARK: APIError class
class APIError: Error {
    let code: Int?
    let message: String?
    var data: Any? = nil
    
    init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
    
    init(message: String?) {
        self.message = message
        self.code = nil
    }
    
    var codeVerify: String {
        if let _json = data as? [String: String] {
            return _json["code_verify"]&
        }
        return ""
    }
    
    init(baseResponse: BaseResponse) {
        self.code = baseResponse.status
        self.message = baseResponse.message
        self.data = baseResponse.data
    }
    
    init(error: Error?) {
        self.code = nil
        self.message = error?.localizedDescription
    }
}

