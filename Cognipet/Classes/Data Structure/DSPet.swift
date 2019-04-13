//
//  DSPet.swift
//  Cognipet
//
//  Created by ShivamSevarik on 20/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class DSPet: NSObject,NSCoding
{
    
    var id:String!
    var name : String!
    var productInventory : String!
    var status : String!
    var breed : String!
    var dateOfBirth : String!
    var fatherId : String!
    var motherId : String!
    var litterId:String!
    var birthPlace:String!
    var currentLocation:String!
    var owner:String?
    var price:String?
    var gender:String?
    
    override init()
    {
        super.init()
        
        id = ""
        name = ""
        birthPlace = ""
        breed = ""
        currentLocation = ""
        dateOfBirth = ""
        fatherId = ""
        motherId = ""
        litterId = ""
        productInventory = ""
        status = "availabel"
        owner = ""
        gender = "male"
    }
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any])
    {
        id = dictionary[Key.id] as? String
        name = dictionary[Key.name] as? String
        productInventory = dictionary[Key.productInventory] as? String
        status = dictionary[Key.status] as? String
        breed = dictionary[Key.breed] as? String
        dateOfBirth = dictionary[Key.dateOfBirth] as? String
        fatherId = dictionary[Key.fatherId] as? String
        motherId = dictionary[Key.motherId] as? String
        litterId = dictionary[Key.litterId] as? String
        birthPlace = dictionary[Key.birthPlace] as? String
        currentLocation = dictionary[Key.currentLocation] as? String
        
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if name != nil{
//            dictionary["name"] = name
//        }
//        if productInventory != nil{
//            dictionary["product_inventory"] = productInventory
//        }
//        return dictionary
//    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: Key.id) as? String
        name = aDecoder.decodeObject(forKey: Key.name) as? String
        productInventory = aDecoder.decodeObject(forKey: Key.productInventory) as? String
        status = aDecoder.decodeObject(forKey: Key.status) as? String
        breed = aDecoder.decodeObject(forKey: Key.breed) as? String
        dateOfBirth = aDecoder.decodeObject(forKey: Key.dateOfBirth) as? String
        fatherId = aDecoder.decodeObject(forKey: Key.fatherId) as? String
        motherId = aDecoder.decodeObject(forKey: Key.motherId) as? String
        litterId = aDecoder.decodeObject(forKey: Key.litterId) as? String
        birthPlace = aDecoder.decodeObject(forKey: Key.birthPlace) as? String
        currentLocation = aDecoder.decodeObject(forKey: Key.currentLocation) as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: Key.id)
        }
        if name != nil{
            aCoder.encode(name, forKey: Key.name)
        }
        if productInventory != nil{
            aCoder.encode(productInventory, forKey: Key.productInventory)
        }
        if status != nil{
            aCoder.encode(status, forKey: Key.status)
        }
        if breed != nil{
            aCoder.encode(breed, forKey: Key.breed)
        }
        if dateOfBirth != nil{
            aCoder.encode(dateOfBirth, forKey: Key.dateOfBirth)
        }
        if fatherId != nil{
            aCoder.encode(fatherId, forKey: Key.fatherId)
        }
        if motherId != nil{
            aCoder.encode(motherId, forKey: Key.motherId)
        }
        if litterId != nil{
            aCoder.encode(litterId, forKey: Key.litterId)
        }
        if birthPlace != nil{
            aCoder.encode(birthPlace, forKey: Key.birthPlace)
        }
        if currentLocation != nil{
            aCoder.encode(currentLocation, forKey: Key.currentLocation)
        }
    }
}
