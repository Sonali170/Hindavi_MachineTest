//
//  GAConstants.swift
//  Ganguram
//
//  Created by Apple on 10/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

//Mark:- Constant Keys for value

//Mark:- Base Url

let GABaseURL = "https://randomuser.me/api"

let GADefault  = UserDefaults()

//Mark:- AppSesvices
struct GAApi  {
    
    static let getUserList = "/?results=50"
    
}

struct GAStoryBoard {
    
   static let Main = UIStoryboard.init(name: "Main", bundle: nil)
}


struct GAMessage {

static let networkError = "Internet connection not available !!!"
}

enum APIStatus: String {
    
    case success = "1"
    case NoContent = "204"
    case BadRequest = "400"
    case ServerError = "500"
    case NotFound = "404"
    
}
