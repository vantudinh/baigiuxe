//
//  Network.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/27/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

/***
 Input: endPoint (all info to request)
 Ouput: data or error
 ***/
import Alamofire
import UIKit

#if PROD || APPSTORE
let BASE_URL = ""
let BASE_URL_IMAGE = ""
#else
let BASE_URL = ""
let BASE_URL_IMAGE = ""
#endif

//---
typealias RequestSuccess = (_ data: Data) -> Void
typealias RequestFailure = (_ error: APIError?) -> Void

//---
typealias NetworkSuccess = (_ data: BaseResponse ) -> Void

let noInternet = APIError(code: 2000, message: "No Internet")

//---
struct SuccessHandler<T> {
    typealias object = (_ object: T?) -> Void
    typealias array = (_ array: [T]) -> Void
    typealias anyObject = (_ object: Any?) -> Void
}

// NetworkPotocol
protocol NetworkRequestProtocol {
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
    func uploadAvatar(image: UIImage, endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
    func uploadFile(endPoint: EndPointType)
    func uploadImages(image: UIImage, endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
    func uploadVideo(endPoint: EndPointType)
}

//---
struct NetworkRequest: NetworkRequestProtocol {
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        
        let url = makeUrl(path: endPoint.path)
        let encoding = getAlamofireEncoding(httpMethod: endPoint.httpMethod)
        //let manager = Alamofire.SessionManager.default
        
        let request = Alamofire.request(url, method: endPoint.httpMethod, parameters: endPoint.parameters, encoding: encoding, headers: endPoint.headers)
        request.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                let apiError = APIError(error: error)
                failure(apiError)
            }
        }
        
    }
    
    func uploadAvatar(image: UIImage, endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
      
        let url = makeUrl(path: endPoint.path)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { (multipartFormData) in
            // image
            if let dataJPG = image.jpegData(compressionQuality: 1) {
                multipartFormData.append(dataJPG, withName: "file", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                
                multipartFormData.append(dataJPG, withName: "crop_file", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
            }
            
            // param
            for (key, value) in endPoint.parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, to: url, method: endPoint.httpMethod, headers: endPoint.headers , encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    print(progress.completedUnitCount)
                })
                
                upload.responseData { (dataResponse) in
                    switch dataResponse.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        let apiError = APIError(error: error)
                        failure(apiError)
                    }
                }
                
            case.failure(let error):
                let apiError = APIError(error: error)
                failure(apiError)
            }
        })
    }
    
    func uploadFile(endPoint: EndPointType) {
        
    }
    
    func uploadVideo(endPoint: EndPointType) {
        
    }
    
    func uploadImages(image: UIImage, endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        
        let url = makeUrl(path: endPoint.path)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { (multipartFormData) in
            // image
            if let dataJPG = image.jpegData(compressionQuality: 1) {
                multipartFormData.append(dataJPG, withName: "img", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
            }
            
            // param
            for (key, value) in endPoint.parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, to: url, method: endPoint.httpMethod, headers: endPoint.headers , encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    print(progress.completedUnitCount)
                })
                
                upload.responseData { (dataResponse) in
                    switch dataResponse.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        let apiError = APIError(error: error)
                        failure(apiError)
                    }
                }
                
            case.failure(let error):
                let apiError = APIError(error: error)
                failure(apiError)
            }
        })
    }
}

// MARK: helper NetworkRequest
extension NetworkRequest {
    private func getAlamofireEncoding(httpMethod: HTTPMethod) -> ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    private func makeUrl(path: String) -> String {
        return "\(BASE_URL)\(path)"
    }
}

