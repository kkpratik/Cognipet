//
//  FormDretailsViewController.swift
//  Cognipet
//
//  Created by Kunal Pable on 20/01/19.
//  Copyright © 2019 SS Incorporation. All rights reserved.
//

import UIKit


let TAG_CHECKED_BUTTON = 1
let TAG_UNCHECKED_BUTTON = 0

let ADD_INFO_FORM_HEIGHT = 520
let PARENT_ID_VIEW_HRIGHT = 40

let DO_YOU_KNOW_THE_FATHER_STRING = "Do you know the father ?"
let DO_YOU_KNOW_THE_MOTHER_STRING = "Do you know the mother ?"

let ADD_FATHER_INFO_STRING = "Yes, Let's add father information"
let ADD_MOTHER_INFO_STRING = "Yes, Let's add mother information"

let FATHER_DETAILS_STRING = "Father Details"
let MOTHER_DETAILS_STRING = "Mother Details"

let SEARCH_INFO_FROM_INVENTORY_STRING = "Yes, Let's search from inventory"

class FormDretailsViewController: UIViewController
{
    
    public var isUsedForFatherDetails = true
    public var petType:PetType!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var saveNextButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var addInfoLabel: UILabel!
    @IBOutlet weak var addInfoButton: UIButton!
    @IBOutlet weak var searchInventoryLabel: UILabel!
    @IBOutlet weak var searchInventoryButton: UIButton!
    @IBOutlet weak var addInfoFormTitle: UILabel!
    @IBOutlet weak var parentIdTexrtField: UITextField!
    @IBOutlet weak var addInfoFormView: UIView!
    @IBOutlet weak var parentIdTextFieldView: UIView!
    
    @IBOutlet weak var addDetailsFormHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var parentIdTextFieldViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var parentNameTextField: UITextField!
    @IBOutlet weak var parentIdTextField: UITextField!
    @IBOutlet weak var parentDOBTextField: UITextField!
    @IBOutlet weak var parentLocationTextField: UITextField!
    @IBOutlet weak var parentBreedTextField: UITextField!
    @IBOutlet weak var parentOwnerNameTextField: UITextField!
    @IBOutlet weak var parentStatusTextField: UITextField!
    
    
    private var shouldShowAddInfoFormView = false
    private var shouldShowParentIdTexrtFieldView = false
    
    //MARK:LifeCycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.title = "Form"
        
        self.setDefaultStateForButtons()
        self.setInformationOnLabels()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    //MARK:IBActions
    
    
    @IBAction func onCencel(_ sender: Any)
    {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func noButtonTapped(_ sender: Any)
    {
        let unCheckedImage = UIImage.init(named: "unCheckedBox")
        let checkedImage = UIImage.init(named: "checkedBox")
        
        if self.noButton.tag == TAG_CHECKED_BUTTON
        {
//            self.noButton.setBackgroundImage(unCheckedImage, for: .normal)
//            self.noButton.tag = TAG_UNCHECKED_BUTTON
        }
        else
        {
            self.noButton.setBackgroundImage(checkedImage, for: .normal)
            self.noButton.tag = TAG_CHECKED_BUTTON
            
            self.addInfoButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.addInfoButton.tag = TAG_UNCHECKED_BUTTON
            
            self.searchInventoryButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.searchInventoryButton.tag = TAG_UNCHECKED_BUTTON
        }
        
        self.shouldShowParentIdTexrtFieldView = false
        self.shouldShowAddInfoFormView =  false
        self.updateViewConstraints()
    }
    
    @IBAction func onAddInfo(_ sender: Any)
    {
        let unCheckedImage = UIImage.init(named: "unCheckedBox")
        let checkedImage = UIImage.init(named: "checkedBox")
        
        if self.addInfoButton.tag == TAG_CHECKED_BUTTON
        {
            self.addInfoButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.addInfoButton.tag = TAG_UNCHECKED_BUTTON
            
            self.noButton.setBackgroundImage(checkedImage, for: .normal)
            self.noButton.tag = TAG_CHECKED_BUTTON
            
            self.shouldShowAddInfoFormView =  false
            
        }
        else
        {
            self.addInfoButton.setBackgroundImage(checkedImage, for: .normal)
            self.addInfoButton.tag = TAG_CHECKED_BUTTON
            
            self.noButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.noButton.tag = TAG_UNCHECKED_BUTTON
            
            self.searchInventoryButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.searchInventoryButton.tag = TAG_UNCHECKED_BUTTON
            
            self.shouldShowAddInfoFormView = true
        }
        
        
        self.shouldShowParentIdTexrtFieldView = false
        self.updateViewConstraints()
    }
    
    @IBAction func onSearchFromInventory(_ sender: Any)
    {
        let unCheckedImage = UIImage.init(named: "unCheckedBox")
        let checkedImage = UIImage.init(named: "checkedBox")
        
        if self.searchInventoryButton.tag == TAG_CHECKED_BUTTON
        {
            self.searchInventoryButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.searchInventoryButton.tag = TAG_UNCHECKED_BUTTON
            
            self.noButton.setBackgroundImage(checkedImage, for: .normal)
            self.noButton.tag = TAG_CHECKED_BUTTON
            
            self.shouldShowParentIdTexrtFieldView = false
        }
        else
        {
            self.searchInventoryButton.setBackgroundImage(checkedImage, for: .normal)
            self.searchInventoryButton.tag = TAG_CHECKED_BUTTON
            
            self.noButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.noButton.tag = TAG_UNCHECKED_BUTTON
            
            self.addInfoButton.setBackgroundImage(unCheckedImage, for: .normal)
            self.addInfoButton.tag = TAG_UNCHECKED_BUTTON
            
            self.shouldShowParentIdTexrtFieldView = true
        }
        
        
        self.shouldShowAddInfoFormView =  false
        self.updateViewConstraints()
    }
    
    @IBAction func onSaveNext(_ sender: Any)
    {
        if self.noButton.tag == TAG_CHECKED_BUTTON
        {
            
        }
        else if self.addInfoButton.tag == TAG_CHECKED_BUTTON
        {
            if let strError = self.isFilledDataValid()
            {
                Utilities.showAlertWithMessage(message: strError, controller: self)
            }
            else
            {
                self.addParent()
            }
        }
        else if self.searchInventoryButton.tag == TAG_CHECKED_BUTTON
        {
            
        }
        else
        {
            Utilities.showAlertWithMessage(message: "Nothing Selected",
                                           controller: self)
        }
    }
    
    //MARK:Overriden Methods
    
    override func updateViewConstraints()
    {
        self.addDetailsFormHeightConstraint.constant = CGFloat(self.shouldShowAddInfoFormView ? ADD_INFO_FORM_HEIGHT : 0)
        self.parentIdTextFieldViewHeightConstraint.constant = CGFloat(self.shouldShowParentIdTexrtFieldView ? PARENT_ID_VIEW_HRIGHT : 0)
        
        super.updateViewConstraints()
    }
    
    //MARK:Private Methods
    private func setDefaultStateForButtons()
    {
        let image = UIImage.init(named: "unCheckedBox")
        let checkedImage = UIImage.init(named: "checkedBox")
        
        self.noButton.setBackgroundImage(checkedImage, for: .normal)
        self.noButton.tag = TAG_CHECKED_BUTTON
        
        self.addInfoButton.setBackgroundImage(image, for: .normal)
        self.addInfoButton.tag = TAG_UNCHECKED_BUTTON
        
        self.searchInventoryButton.setBackgroundImage(image, for: .normal)
        self.searchInventoryButton.tag = TAG_UNCHECKED_BUTTON
    }
    
    private func setInformationOnLabels()
    {
        self.questionLabel.text = self.isUsedForFatherDetails ? DO_YOU_KNOW_THE_FATHER_STRING : DO_YOU_KNOW_THE_MOTHER_STRING
        self.addInfoLabel.text  = self.isUsedForFatherDetails ? ADD_FATHER_INFO_STRING : ADD_MOTHER_INFO_STRING
        self.addInfoFormTitle.text = self.isUsedForFatherDetails ? FATHER_DETAILS_STRING : MOTHER_DETAILS_STRING
        self.searchInventoryLabel.text = SEARCH_INFO_FROM_INVENTORY_STRING
    }
    
    private func isFilledDataValid() -> String?
    {
        var strError:String? = nil
        
        if !Utilities.isValidString(self.parentNameTextField.text)
        {
            strError = "Name can not be empty"
        }
        if !Utilities.isValidString(self.parentIdTextField.text)
        {
            strError = "Micro chip ID can not be empty"
        }
        if !Utilities.isValidString(self.parentDOBTextField.text)
        {
            strError = "D.O.B. can not be empty"
        }
        if !Utilities.isValidString(self.parentLocationTextField.text)
        {
            strError = "Location can not be empty"
        }
        if !Utilities.isValidString(self.parentBreedTextField.text)
        {
            strError = "Breed can not be empty"
        }
        if !Utilities.isValidString(self.parentOwnerNameTextField.text)
        {
            strError = "Owner can not be empty"
        }
        if !Utilities.isValidString(self.parentStatusTextField.text)
        {
            strError = "Status can not be empty"
        }
        
        return strError
    }
    
    private func addParent()
    {
        let name = self.parentNameTextField.text ?? ""
        let id = self.parentIdTextField.text ?? ""
        let dob = "2012-11-22"//self.parentDOBTextField.text
        let location = self.parentLocationTextField.text ?? ""
        let breed = self.parentBreedTextField.text ?? ""
        let owner = self.parentOwnerNameTextField.text ?? ""
        let status = "sold"//self.parentStatusTextField.text
        let gender = self.isUsedForFatherDetails ? "0" : "1"
        let inventory = "72cd35c5-5a32-44e3-9dbb-2638e64a8400"
        
        
        let dict = NSDictionary.init(objects: [name,
                                               id,
                                               dob,
                                               location,
                                               location,
                                               breed,
                                               owner,
                                               status,
                                               gender,
                                               inventory,],
                                     forKeys: [Key.name as NSCopying,
                                               Key.microchipId as NSCopying,
                                               Key.dateOfBirth as NSCopying,
                                               Key.birthPlace as NSCopying,
                                               Key.currentLocation as NSCopying,
                                               Key.breed as NSCopying,
                                               Key.owner as NSCopying,
                                               Key.status as NSCopying,
                                               Key.locality as NSCopying,
                                               Key.productInventory as NSCopying])
        
        APIManager.shared.makeAPIRequest(ofType:MethodType.post
            , withEndpoint: Endpoint.addParent,
            andParam: dict,
            shouldAuthenticate: true,
            showHUD: true)
        { (responseDict, error) in
            
            if error != nil
            {
                Utilities.showAlertWithMessage(message: error?.localizedDescription ?? DEFAULT_ERROR_STRING,
                                               controller: self)
            }
            else
            {
                guard let dictionary = responseDict,
                    let status = dictionary.object(forKey:Key.status) as? Int,
                    status == 201
                    else{return}
                
                let petParentInfoDict = dictionary.object(forKey: Key.data) as? NSDictionary ?? NSDictionary()
                
                let petParenrt = DSPet.init(fromDictionary: petParentInfoDict as! [String:Any])
             
                
            }
        }
        
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
