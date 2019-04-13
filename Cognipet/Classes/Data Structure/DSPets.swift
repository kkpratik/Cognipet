//
//  DSPets.swift
//  Cognipet
//
//  Created by ShivamSevarik on 20/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class DSPets: NSObject {

    var pets:[DSPet?]?
    
    override init()
    {
        super.init()
        self.pets = [DSPet?]()
    }
    
}
