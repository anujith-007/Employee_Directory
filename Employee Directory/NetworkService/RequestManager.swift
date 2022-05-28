//
//  RequestManager.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import Foundation
import Alamofire


class APIManager: NSObject {
    
    class func requestGETURL(_ url: String,isHeader: Bool, onSuccess success: @escaping success, onFailure failure: @escaping failure, onAuthfail AuthHandler: @escaping AuthHandler){
        
        let header: HTTPHeaders? = [:]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if response.response?.statusCode == 401 {
                AuthHandler(false)
            }else{
                switch response.result {
                case let .success(value):
                    //                    print(JSON(value))
                    
                    success(value as AnyObject)
                case let .failure(error):
                    failure(error)
                }
            }
        }
    }
    
}
