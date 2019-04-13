//
//  AddInventoryViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 16/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

protocol AddInventoryViewControllerDelegate
{
    func addInventoryViewController(_ controller:AddInventoryViewController,
                                    didAddNewInventory inventory:DSInventory)
    
    func addInventoryViewController(_ controller:AddInventoryViewController,
                                    updatedInventory inventory:DSInventory)
}

class AddInventoryViewController: UIViewController, //UITextFieldDelegate,
    UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var buttonAddIcon: UIButton!
    @IBOutlet weak var textFieldInventoryName: UITextField!
    @IBOutlet weak var textFieldCategory: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    
    public var delegate:AddInventoryViewControllerDelegate?
    private var inventoryTypes:[String:String]?
    var categoriesPicker = UIPickerView()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.setupPickerView()
        self.navigationItem.hidesBackButton = true
        self.getInventoryTypes()
    }
    
    @IBAction func onCancel(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAddIcon(_ sender: Any)
    {
        //direct segue from story board
    }
    
    @IBAction func onAddInventory(_ sender: Any)
    {
        if let name = textFieldInventoryName.text, name != ""
        {
            if let category = textFieldCategory.text, category != ""
            {
                if let location = textFieldLocation.text, location != ""
                {
                    let catId = (self.inventoryTypes! as NSDictionary).object(forKey: category) as! String
                    
                    self.addInventory(withName: name,
                                      category: catId,
                                      location: location)
                }
                else
                {
                    Utilities.showAlertWithMessage(message: "Invald Location",
                                                   controller: self)
                }
            }
            else
            {
                Utilities.showAlertWithMessage(message: "Invalid Category",
                                               controller:  self)
            }
        }
        else
        {
            Utilities.showAlertWithMessage(message: "Invalid Name",
                                           controller:self)
        }
    }
    
    //MARK:UIPickerView DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int
    {
        return self.inventoryTypes?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String?
    {
        var title = ""
        
        if let categoryNmae = self.getCategoryAtIndex(row)
        {
            title = categoryNmae
        }
        
        return title
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        if let categoryName = self.getCategoryAtIndex(row)
        {
            self.textFieldCategory.text = categoryName
        }
    }
    
    private func getCategoryAtIndex(_ nIndex:Int) -> String?
    {
        var categoryName:String? = nil
        
        if let dictInventoryTypes = (self.inventoryTypes as NSDictionary?)
        {
            let keys = dictInventoryTypes.allKeys as! [String]
            categoryName = keys[nIndex]
        }

        return categoryName
    }
    
    //MARK:Reload Methods
    func reloadPickerComponents()
    {
        DispatchQueue.main.async
            {
                self.categoriesPicker.reloadAllComponents()
        }
    }
    
    
    //MARK:Private Method
    private func setupPickerView()
    {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem.init(title: "Done",
                                              style: UIBarButtonItem.Style.done,
                                              target:self ,
                                              action:#selector(onDonePicker))
        
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.textFieldCategory.inputView = self.categoriesPicker
        self.textFieldCategory.inputAccessoryView = toolBar

        self.categoriesPicker.dataSource = self
        self.categoriesPicker.delegate = self

    }
    
    @objc func onDonePicker()
    {
        self.textFieldCategory.resignFirstResponder()
    }
    
    private func addInventory(withName strName:String,
                              category strCategory:String,
                              location strLocation:String)
    {
        let isActive = "true"
        let country = "fdsfsff"
        let city = "fsdfsdf"
        let locality = "dfdsfsd"
        
        let dict = NSDictionary.init(objects: [strName,
                                               strCategory,
                                               strLocation,
                                               isActive,
                                               country,
                                               city,
                                               locality],
                                     forKeys: [Key.name as NSCopying,
                                               Key.inventoryType as NSCopying,
                                               Key.location as NSCopying,
                                               Key.isActive as NSCopying,
                                               Key.country as NSCopying,
                                               Key.city as NSCopying,
                                               Key.locality as NSCopying])
        
        APIManager.shared.makeAPIRequest(ofType: MethodType.post,
                                         withEndpoint: Endpoint.inventory,
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
                
                let inventoryDict = dictionary.object(forKey: Key.data) as? NSDictionary ?? NSDictionary()
                
                let inventory = DSInventory.init(fromDictionary: inventoryDict as! [String:Any])
                
                if let delegate = self.delegate
                {
                    delegate.addInventoryViewController(self,
                                                        didAddNewInventory: inventory)
                    
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    private func getInventoryTypes()
    {
        APIManager.shared.makeAPIRequest(ofType: MethodType.get,
                                         withEndpoint: Endpoint.inventoryType,                                         andParam: nil,
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
                    status == 200
                    else{return}
                
                let userTypes = dictionary.object(forKey: Key.records) as? [NSDictionary] ?? [NSDictionary]()
                
                for user in userTypes
                {
                    guard
                        let id = user.object(forKey: Key.id) as? String,
                        let name = user.object(forKey: Key.name) as? String
                        
                    else
                        {return}
                                        
                    if self.inventoryTypes == nil
                    {
                        self.inventoryTypes = [String:String]()
                        self.inventoryTypes?[name] = id
                    }
                    else
                    {
                        self.inventoryTypes?[name] = id
                    }
                }
                
                self.reloadPickerComponents()
                
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
