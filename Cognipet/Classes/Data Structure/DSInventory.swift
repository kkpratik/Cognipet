//
//  DSInventory.swift
//  Cognipet
//
//  Created by ShivamSevarik on 19/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class DSInventory: NSObject, NSCoding
{
    
    var name : String
    var id : String
    var city : String
    var country : String
    var inventoryType : String
    var isActive : Bool
    var locality : String?
    var location : String
    var longitude : String?
    var latitude : String?
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any])
    {
        city = dictionary[Key.city] as? String ?? ""
        country = dictionary[Key.count] as? String ?? ""
        id = dictionary[Key.id] as? String ?? ""
        inventoryType = dictionary[Key.inventoryType] as! String
        let strIsActive = dictionary[Key.isActive] as? String
        isActive = strIsActive  == "true" ? true : false
        latitude = dictionary[Key.latitude] as? String ?? ""
        longitude = dictionary[Key.longitude] as? String ?? ""
        locality = dictionary[Key.locality] as? String ?? ""
        location = dictionary[Key.location] as? String ?? ""
        name = dictionary[Key.name] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if city != nil{
//            dictionary["city"] = city
//        }
//        if country != nil{
//            dictionary["country"] = country
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if inventoryType != nil{
//            dictionary["inventory_type"] = inventoryType
//        }
//        if isActive != nil{
//            dictionary["is_active"] = isActive
//        }
//        if lat != nil{
//            dictionary["lat"] = lat
//        }
//        if locality != nil{
//            dictionary["locality"] = locality
//        }
//        if location != nil{
//            dictionary["location"] = location
//        }
//        if longitude != nil{
//            dictionary["longitude"] = longitude
//        }
//        if name != nil{
//            dictionary["name"] = name
//        }
//        return dictionary
//    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        city = (aDecoder.decodeObject(forKey: Key.city) as? String)!
        country = (aDecoder.decodeObject(forKey: Key.country) as? String)!
        id = (aDecoder.decodeObject(forKey: Key.id) as? String)!
        inventoryType = (aDecoder.decodeObject(forKey: Key.inventoryType) as? String)!
        isActive = aDecoder.decodeBool(forKey: Key.isActive) as Bool
        latitude = aDecoder.decodeObject(forKey: Key.latitude) as? String
        locality = aDecoder.decodeObject(forKey: Key.locality) as? String
        location = (aDecoder.decodeObject(forKey: Key.location) as? String)!
        longitude = aDecoder.decodeObject(forKey: Key.longitude) as? String
        name = (aDecoder.decodeObject(forKey: Key.name) as? String)!
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
            aCoder.encode(city, forKey: Key.city)
            aCoder.encode(country, forKey: Key.country)
            aCoder.encode(id, forKey: Key.id)
            aCoder.encode(inventoryType, forKey: Key.inventoryType)
            aCoder.encode(isActive, forKey: Key.isActive)
            aCoder.encode(latitude, forKey: Key.latitude)
            aCoder.encode(locality, forKey: Key.locality)
            aCoder.encode(location, forKey: Key.location)
            aCoder.encode(longitude, forKey:Key.longitude)
            aCoder.encode(name, forKey: Key.name)
    }
}
