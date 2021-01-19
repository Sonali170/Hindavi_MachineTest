//
//  GAServiceManager.swift
//  Ganguram
//
//  Created by Apple on 10/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation


class GAService: NSObject {
    
    static var shared: GAService = GAService()
    
    
    //MARK:- Api for calling get user list & Details.......
    
    func apiForGetUserList(completionHandler:@escaping (_ isSuccess:Bool?, _ strError:String?, _ response:[String: Any]?)->Void) {
        
        
        GAApiManager.shared.GETRequest(strURL:  GAApi.getUserList) { (result) in
            
            switch(result) {
            case .success(let value):
                
                    
                    let response = value as! [String: Any]
                        
                        do {
                            
                            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: response, requiringSecureCoding: true)
                            print(encodedData)
                        } catch {
                            print(error.localizedDescription)
                            // or display a dialog
                        }
                        
                        completionHandler(true,"", response)
                
            case .error(let error):
                completionHandler(false,error.localizedDescription, [:])
            }
        }
        
    }
}






