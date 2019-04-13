//
//  AddPetDertailsCell.swift
//  Cognipet
//
//  Created by Kunal Pable on 10/02/19.
//  Copyright © 2019 SS Incorporation. All rights reserved.
//

import UIKit

protocol AddPetDetailsCellDelegate
{
    func petDetailsCell(addNewCellButtonTapped cell:AddPetDertailsCell)
    
    func petDetailsCell(deleteCellButtonTapped cell:AddPetDertailsCell)
}

class AddPetDertailsCell: UITableViewCell {


    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var microchipIdTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var petPriceTextField: UITextField!
    
    @IBOutlet weak var availabelStatusButton: UIButton!
    @IBOutlet weak var soldStatusButton: UIButton!
    
    @IBOutlet weak var maleGenderButton: UIButton!
    @IBOutlet weak var femaleGenderButton: UIButton!
    
    public var delegate:AddPetDetailsCellDelegate?
    
    
    //MARK:LifeCycle Methods
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.setDefaultStateForButtons()
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
    }
    
    override func prepareForReuse()
    {
//        self.setDefaultStateForButtons()
//        self.petNameTextField.text = ""
//        self.microchipIdTextField.text = ""
//        self.ownerNameTextField.text = ""
    }
    
    //MARK:IBActions
    @IBAction func onAvailabelStatusButton(_ sender: Any)
    {
        if self.availabelStatusButton.tag != TAG_CHECKED_BUTTON
        {
            self.availabelStatusButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.availabelStatusButton.tag = TAG_CHECKED_BUTTON
            
            self.soldStatusButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.soldStatusButton.tag = TAG_UNCHECKED_BUTTON
        }
    }
    
    @IBAction func onSoldStatusButton(_ sender: Any)
    {
        if self.soldStatusButton.tag != TAG_CHECKED_BUTTON
        {
            self.soldStatusButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.soldStatusButton.tag = TAG_CHECKED_BUTTON
            
            self.availabelStatusButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.availabelStatusButton.tag = TAG_UNCHECKED_BUTTON
        }
    }
    
    @IBAction func onMaleGenderButton(_ sender: Any)
    {
        if self.maleGenderButton.tag != TAG_CHECKED_BUTTON
        {
            self.maleGenderButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.maleGenderButton.tag = TAG_CHECKED_BUTTON
            
            self.femaleGenderButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.femaleGenderButton.tag = TAG_UNCHECKED_BUTTON
        }
    }
    
    @IBAction func onFemaleGenderButton(_ sender: Any)
    {
        if self.femaleGenderButton.tag != TAG_CHECKED_BUTTON
        {
            self.femaleGenderButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.femaleGenderButton.tag = TAG_CHECKED_BUTTON
            
            self.maleGenderButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.maleGenderButton.tag = TAG_UNCHECKED_BUTTON
        }
    }
    
    @IBAction func onAddNewPetDetailCell(_ sender: Any)
    {
        if let pDelegate = self.delegate
        {
            pDelegate.petDetailsCell(addNewCellButtonTapped: self)
        }
    }
    
    @IBAction func onDeletePetDetailCell(_ sender: Any)
    {
        if let pDelegate = self.delegate
        {
            pDelegate.petDetailsCell(deleteCellButtonTapped: self)
        }
    }
 
    //MARK:Public Method
    
    public func setIsAvailable(_ bIsAvailable:Bool)
    {
        if bIsAvailable
        {
            self.availabelStatusButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.availabelStatusButton.tag = TAG_CHECKED_BUTTON
            
            self.soldStatusButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.soldStatusButton.tag = TAG_UNCHECKED_BUTTON
        }
        else
        {
            self.availabelStatusButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.availabelStatusButton.tag = TAG_UNCHECKED_BUTTON
            
            self.soldStatusButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.soldStatusButton.tag = TAG_CHECKED_BUTTON
        }
    }
    
    public func setIsMaleGender(_ bIsMale:Bool)
    {
        if bIsMale
        {
            self.maleGenderButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.maleGenderButton.tag = TAG_CHECKED_BUTTON
            
            self.femaleGenderButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.femaleGenderButton.tag = TAG_UNCHECKED_BUTTON
        }
        else
        {
            self.maleGenderButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
            self.maleGenderButton.tag = TAG_UNCHECKED_BUTTON
            
            self.femaleGenderButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
            self.femaleGenderButton.tag = TAG_CHECKED_BUTTON
        }
    }
    
    public func getPet() -> DSPet
    {
        let pet = DSPet.init()
        
        pet.name = self.petNameTextField.text ?? ""
        pet.id = self.microchipIdTextField.text ?? ""
        pet.owner = self.ownerNameTextField.text ?? ""
        pet.price = self.petPriceTextField.text ?? ""
        pet.status = self.availabelStatusButton.tag == TAG_CHECKED_BUTTON ? "availabel" : "sold"
        pet.gender = self.maleGenderButton.tag == TAG_CHECKED_BUTTON ? "male" : "female"
        
        return pet
    }
    
    //MARK:Private Methods
    
    private func setDefaultStateForButtons()
    {
        
        self.availabelStatusButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
        self.availabelStatusButton.tag = TAG_CHECKED_BUTTON
        
        self.soldStatusButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
        self.soldStatusButton.tag = TAG_UNCHECKED_BUTTON
        
        self.maleGenderButton.setBackgroundImage(self.getCheckedImag(), for: .normal)
        self.maleGenderButton.tag = TAG_CHECKED_BUTTON
        
        self.femaleGenderButton.setBackgroundImage(self.getUncheckedImage(), for: .normal)
        self.femaleGenderButton.tag = TAG_UNCHECKED_BUTTON
    }
    
    private func getCheckedImag() -> UIImage
    {
        let checkImage = UIImage.init(named: "checkedBox")
        return checkImage ?? UIImage()
    }
    
    private func getUncheckedImage() -> UIImage
    {
        let unCheckimage = UIImage.init(named: "unCheckedBox")
        return unCheckimage ?? UIImage()
    }
    
}
