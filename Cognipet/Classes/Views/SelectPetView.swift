//
//  SelectPetView.swift
//  Cognipet
//
//  Created by Kunal Pable on 09/02/19.
//  Copyright © 2019 SS Incorporation. All rights reserved.
//

import UIKit

class SelectPetView: UIView
{

    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    private var compeletionBlock:((PetType) -> Void)?
    
    public func executeBlockOnSelection(_ onSelection: @escaping (PetType) -> Void)
    {
        self.compeletionBlock = onSelection
    }
    
    @IBAction func selectCat(_ sender: Any)
    {
        if let block = self.compeletionBlock
        {
            block(PetType.cat)
        }
    }
    
    @IBAction func selectDog(_ sender: Any)
    {
        if let block = self.compeletionBlock
        {
            block(PetType.dog)
        }
    }
}
