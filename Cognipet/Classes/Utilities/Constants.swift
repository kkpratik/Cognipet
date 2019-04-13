//
//  Constants.swift
//  Njoy.ai
//
//  Created by Shivam Sevarik on 27/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

let DEFAULT_ERROR_STRING = "Something went wrong"

struct Key {
    
    static let status = "status"
    static let message = "message"
    static let records = "records"
    static let data = "data"
    static let detail = "detail"
    static let results = "results"
    static let authorization = "Authorization"
    
    static let count = "count"
    static let next = "next"
    static let previous = "previous"
    
    static let id = "id"
    static let email = "email"
    static let name = "name"
    static let password = "password"
    static let signupType = "singup_type"
    static let userType = "user_type"
    static let socialToken = "social_token"
    static let token = "token"
    static let location = "location"
    static let isActive = "is_active"
    static let country = "country"
    static let city = "city"
    static let locality = "locality"
    static let inventoryType = "inventory_type"
    static let productInventory = "product_inventory"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let breed = "breed"
    static let dateOfBirth = "date_of_birth"
    static let birthPlace = "birth_place"
    static let fatherId = "father_id"
    static let motherId = "mother_id"
    static let litterId = "litter_id"
    static let currentLocation = "current_location"
    static let gender = "gender"
    static let microchipId = "microchip_id"
    static let owner = "owner"

}

struct SignupType {
    
    static let cognipet = "0"
    static let facbook = "1"
    static let google = "2"
}

struct UserTypeKey
{
    static let petLover = "PET LOVER"
    static let petBreeder = "BREEDER"
}

struct Endpoint {
    
    static let signup = "singup"
    static let login = "login"
    static let logout = "logout"
    static let userTypes = "user-types"
    static let inventoryType = "inventory-type"
    static let inventory = "inventory"
    static let products = "products"
    static let productsByInventoryId = "products/pk-of-inventory/product-by-inventory"
    static let addParent = "add-pet-parents"
}

struct MethodType {
    
    static let get = "GET"
    static let post = "POST"
    static let put = "PUT"
    static let delete = "DELETE"
}

enum PetType {
    
    case dog, cat
}
