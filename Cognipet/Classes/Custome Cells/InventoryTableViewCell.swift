//
//  InventoryTableViewCell.swift
//  Cognipet
//
//  Created by ShivamSevarik on 15/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class InventoryTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelcategoryName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var inventoryImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK:Lifecycle Methods
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        self.containerView.dropShadow()
        
    }

    //MARK:Private Methods

}

extension UIView
{
    func dropShadow()
    {
        self.clipsToBounds = false
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.layer.shadowOpacity = 0.2
    }
}

