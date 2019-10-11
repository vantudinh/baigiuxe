//
//  Network.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/27/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//
//
import Foundation
import ObjectMapper
import SwiftyJSON

/***
 Input: endPoint (all info to request)
 Ouput: BaseResponse or error
 ***/

protocol APINetworkProtocol {
    func requestData(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func uploadImages(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func uploadAvatar(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
}

struct APINetwork: APINetworkProtocol {
    let request: NetworkRequestProtocol
    
    init(request: NetworkRequestProtocol) {
        self.request = request
    }
    
    func requestData(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print("\(BASE_URL)\(endPoint.path)")
        print(endPoint.parameters)
        print(endPoint.headers)
        request.requestData(endPoint: endPoint, success: { data in
            let json = JSON(data)
            
            if json.description == "null" {
                print("\n**************ERROR*****************")
                print(String(data: data, encoding: .utf8))
            } else {
                print("\n**************SUCCESS*****************")
                print(json)
            }
            
            
            guard let result = Mapper<BaseResponse>().map(JSONObject: json.dictionaryObject) else {
                failure(APPError.canNotParseData)
                return
            }
            
            self.handleResponse(response: result, success: success, failure: failure)
            
        }) { error in
            print("APINetwork - requestData: \(String(describing: error?.code?.description&))")
            failure(APIError(error: error))
        }
    }
    
    func uploadAvatar(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print(endPoint.parameters)
        
        request.uploadAvatar(image: image, endPoint: endPoint, success: { data in
            let json = JSON(data)
            print(json)
            
            guard let result = Mapper<BaseResponse>().map(JSONObject: json.dictionaryObject) else {
                failure(APPError.canNotParseData)
                return
            }
            
            self.handleResponse(response: result, success: success, failure: failure)
        }) { error in
            print("APINetwork - uploadImages: \(String(describing: error?.code?.description&))")
            failure(APIError(error: error))
        }
    }
    
    func uploadImages(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print(endPoint.parameters)
        
        request.uploadImages(image: image, endPoint: endPoint, success: { data in
            let json = JSON(data)
            print(json)
            
            guard let result = Mapper<BaseResponse>().map(JSONObject: json.dictionaryObject) else {
                failure(APPError.canNotParseData)
                return
            }
            
            self.handleResponse(response: result, success: success, failure: failure)
        }) { error in
            print("APINetwork - uploadImages: \(String(describing: error?.code?.description&))")
            failure(APIError(error: error))
        }
    }
}

// handle base response
extension APINetwork {
    private func handleResponse(response: BaseResponse, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        if response.status == 200 || response.status == nil {
            success(response)
        } else {
            // handle error with message from API
            let error = APIError(baseResponse: response)
            failure(error)
        }
    }
}


