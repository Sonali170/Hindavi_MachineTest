//
//  HTUserListModelClass.swift
//  HindaviTest
//
//  Created by Sonali on 17/01/21.
//  Copyright © 2021 Sonali. All rights reserved.
//

import Foundation


class HTUserList  {
    
    var arrayUserList = [HTUserDetail]()
    static let shared = HTUserList()
    
    func saveUserData(arrayUsers : [[String : Any]]) {
        
        arrayUserList.removeAll()
        
        for  dict in arrayUsers {
            
            let deatil = HTUserDetail.init(json: dict)
            arrayUserList.append(deatil)
        }
    }
}


//Mark -> Model for ParsingData of User

class HTUserDetail {
    
    var email: String?
    var gender: String?
    var loginDetail : HTloginDetail?
    var DOBDetail : HTDOBDetail?
    var nameDetail : HTNameDetail?
    var pictureDetail : HTPictureDetail?
    var Phone : String?
    var locationDetail : HTLocationDetail?
    
    init(json: [String: Any]) {
        
        self.email = json["email"] as? String ?? ""
        self.gender = json["gender"] as? String ?? ""
        self.Phone = json["phone"] as? String ?? ""
        
        if let loginDetail = json["login"] as? [String:Any] {
            self.loginDetail = HTloginDetail.init(json: loginDetail)
        }
        
        if let pictureDetail = json["picture"] as? [String:Any] {
            self.pictureDetail = HTPictureDetail.init(json: pictureDetail)
        }
        
        if let nameDetail = json["name"] as? [String:Any] {
            self.nameDetail = HTNameDetail.init(json: nameDetail)
        }
        
        if let DOBDetail = json["dob"] as? [String:Any] {
            self.DOBDetail = HTDOBDetail.init(json: DOBDetail)
        }
        
        if let locationDetail = json["location"] as? [String:Any] {
            self.locationDetail = HTLocationDetail.init(json: locationDetail)
        }
        
    }
}

//Mark -> Model for ParsingData of login

class HTloginDetail : Encodable, Decodable{
    
    var md5: String?
    var password: String?
    var salt: String?
    var sha1: String?
    var sha256: String?
    var username: String?
    var uuid: String?
    
    init(json: [String: Any]) {
        
        self.md5 = json["md5"] as? String ?? ""
        self.password = json["password"] as? String ?? ""
        self.salt = json["salt"] as? String ?? ""
        self.sha1 = json["sha1"] as? String ?? ""
        self.sha256 = json["sha256"] as? String ?? ""
        self.username = json["username"] as? String
        self.uuid = json["uuid"] as? String ?? ""
    }
}

//Mark -> Model for ParsingData of Picture

class HTPictureDetail : Encodable, Decodable{
    
    var large: String?
    var medium: String?
    var thumbnail: String?
    
    init(json: [String: Any]) {
        
        self.large = json["large"] as? String ?? ""
        self.medium = json["medium"] as? String ?? ""
        self.thumbnail = json["thumbnail"] as? String ?? ""
    }
}

//Mark -> Model for ParsingData of nameDetail

class HTNameDetail : Encodable, Decodable{
    
    var first: String?
    var last: String?
    var title: String?
    
    init(json: [String: Any]) {
        
        self.first = json["first"] as? String ?? ""
        self.last = json["last"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
    }
}

//Mark -> Model for ParsingData of DOB

class HTDOBDetail : Encodable, Decodable{
    
    var date: String?
    
    init(json: [String: Any]) {
        
        self.date = json["date"] as? String ?? ""
    }
    
}

//Mark -> Model for ParsingData of Location

class HTLocationDetail {
    
    var city: String?
    var country: String?
    var postcode: String?
    var state: String?
    
    init(json: [String: Any]) {
        
        self.city = json["city"] as? String ?? ""
        self.country = json["country"] as? String ?? ""
        self.postcode = json["postcode"] as? String ?? ""
        self.state = json["state"] as? String ?? ""
        
    }
}


