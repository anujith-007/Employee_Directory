//
//  DataGenerator.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import Foundation
import Alamofire


class DataGenerator {
    
    static func fetchEmployeeListApi(handler : @escaping wsHandler){
        
        let url = employeURL
        //let param = [:] as [String : AnyObject]
        
        APIManager.requestGETURL(url, isHeader: false , onSuccess: { (response) in
            
            handler(true, response, true)
            
        }, onFailure: {(error) in
            
            print(error as Any)
            handler(false, error as AnyObject, true)
            
        }, onAuthfail: { (Authsuccess) in
            if Authsuccess {
                print("Autharized")
            }else{
                handler(false, "unAutharized" as AnyObject, false)
            }
            
        })
        
    }
    
}
