//
//  BaseFile.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import Foundation
import Alamofire

let employeURL = "http://www.mocky.io/v2/5d565297300000680030a986"

/*
 API Completion Handler
 */

typealias success = (_ Result: AnyObject) -> ()
typealias progress = (_ progress: AnyObject) -> ()
typealias failure = (Error) -> ()
typealias wsHandler = (_ success: Bool, _ Result: AnyObject, _ Authsuccess: Bool) -> ()
typealias AuthHandler = (_ Authsuccess: Bool) -> ()

let rechability = NetworkReachabilityManager()
