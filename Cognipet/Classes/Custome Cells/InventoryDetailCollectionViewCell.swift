//
//  InventoryDetailCollectionViewCell.swift
//  Cognipet
//
//  Created by ShivamSevarik on 16/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class InventoryDetailCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var cellBackgroundImageView: UIImageView!
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib()
    {
        self.layer.cornerRadius = 7
    }
    
}
