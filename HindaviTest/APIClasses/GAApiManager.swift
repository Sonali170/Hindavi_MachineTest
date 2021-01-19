//
//  GAApiManager.swift
//  Ganguram
//
//  Created by Apple on 10/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

enum ApiResult<T, Error> {
    case success(T)
    case error(Error)
}

class GAApiManager: NSObject {
    
    typealias CompletionClosure = (ApiResult<Any,Error>) -> ()
    fileprivate var completionHandler:CompletionClosure!
    typealias completionHandlerForStatus = (_ success:Bool) -> Void
    
    static var shared: GAApiManager = GAApiManager()
    
    private let session: Session = {
        
        let manager = ServerTrustManager(evaluators: ["randomuser.me": DisabledEvaluator()])
        
        let configuration = URLSessionConfiguration.af.default
         return Session(configuration: configuration, serverTrustManager: manager)
        
    }()
        
    
    //Mark ->   Api for GET Request
    
    func GETRequest(strURL: String,callback: ((ApiResult<Any, Error>) -> Void)?) {
        self.completionHandler = callback
        
        let url = "\(GABaseURL)\(strURL)"
        
        session.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let dict:[String:Any] = value as! [String : Any]
                callback!(.success(dict))
                break
            case .failure(let error):
                callback!(.error(error))
            }
        }
    }
    
    //Mark ->   Api for GET with Parameter
    
    func GETRequestIWithParam(strURL: String, Param: [String: Any], callback: ((ApiResult<Any, Error>) -> Void)?) {
        
        self.completionHandler = callback
        session.request(strURL, method:.get, parameters : Param).responseJSON(completionHandler: { response in
            
            switch(response.result) {
            case .success(_):
                if let data = response.value {
                    let dict:[String:Any] = data as! [String : Any]
                    callback!(.success(dict))
                }
                break
            case .failure(let error):
                callback!(.error(error))
                break
            }
        })
    }
    
   
}


