//
//  PetProfileViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 02/01/19.
//  Copyright © 2019 SS Incorporation. All rights reserved.
//

import UIKit

class PetProfileViewController: UIViewController {

    @IBOutlet weak var imageViewBackGround: UIImageView!
    
    @IBOutlet weak var imageViewProfilePicture: UIImageView!
    
    @IBOutlet weak var labelPetAge: UILabel!
    
    @IBOutlet weak var labelPetPrice: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelOwnerName: UILabel!
    @IBOutlet weak var labelEmailId: UILabel!
    @IBOutlet weak var labelContactNumber: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var imageViewLocationIcon: UIImageView!
    
    @IBOutlet weak var imageViewOwnerName: UIImageView!
    @IBOutlet weak var imageViewEmailIcon: UIImageView!
    @IBOutlet weak var imageViewPhoneIcon: UIImageView!
    @IBOutlet weak var imageViewDescriptionIcon: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
