//
//  User.swift
//  Cognipet
//
//  Created by ShivamSevarik on 20/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import Foundation

class User: NSObject
{
    static let currentUser = User()
    
    var sessionToken:String?
    var name:String?
    var email:String?
    var userTypeKey:String!
    var inventoryTypes:[String:String]?
}
