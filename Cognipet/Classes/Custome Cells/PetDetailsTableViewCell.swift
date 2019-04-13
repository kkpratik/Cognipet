//
//  PetDetailsTableViewCell.swift
//  Cognipet
//
//  Created by ShivamSevarik on 01/01/19.
//  Copyright © 2019 SS Incorporation. All rights reserved.
//

import UIKit

class PetDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var labelPetName: UILabel!
    @IBOutlet weak var labelPetAge: UILabel!
    @IBOutlet weak var labelPetGender: UILabel!
    @IBOutlet weak var labelPetPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containerView.layer.cornerRadius = 15
//        self.petImage.layer.cornerRadius = 50
        
        self.containerView.dropShadow()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
