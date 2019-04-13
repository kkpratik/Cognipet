//
//  InventoriesViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 15/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class InventoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddInventoryViewControllerDelegate
{
    
    @IBOutlet weak var inventoryTableView: UITableView!
    @IBOutlet weak var noInventoryView: UIView!
    
    var inventories = DSInventories()
    public var isNewSignup:Bool!
    private var selectedIndex:Int?
    private var recordCount:Int = 0
    
    //MARK:Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        self.getInventoryTypes()
        
        self.setupTableView()
        
        if isNewSignup
        {
            self.inventoryTableView.isHidden = true
        }
        else
        {
            self.loadInventories()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:IBActions
    
    @IBAction func onAddNewInventory(_ sender: Any)
    {
        
    }
    
    //MARK:TableView DataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return self.inventories.inventories.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        self.selectedIndex = indexPath.row
        
        let identifire = "InventoryTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire) as! InventoryTableViewCell
        if let inventory = self.inventories.inventories[indexPath.row]
        {
            cell.labelTitle.text = inventory.name
            cell.labelcategoryName.text = self.getInventroryrryTypeNameForId(inventory.inventoryType)
            cell.labelLocation.text = inventory.location
            cell.inventoryImage.image = self.imageForInventoryType(cell.labelcategoryName.text ?? "")
        }
        
        return cell
    }
    //MARK:TableView Delegate
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        self.selectedIndex = indexPath.row
        
        DispatchQueue.main.async
            {
//                self.performSegue(withIdentifier: "InventoryDetailViewController",
//                                  sender: nil)
                self.performSegue(withIdentifier: "PetDetailViewController",
                                  sender: nil)
        }
    }
    
    //MARK:TableView Editing
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            
            //TODO:need to add alert
            self.inventories.inventories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let update = UITableViewRowAction(style: .default, title: "Upate") { (action, indexPath) in

        }
        
        update.backgroundColor = UIColor.lightGray
        
        return [delete, update]
        
    }
    
    //MARK:Reload Method
    private func reloadInventories()
    {
        DispatchQueue.main.async
            {
                let hideNoInventoryView = self.inventories.inventories.count > 0 ? true : false
                
                self.noInventoryView.isHidden = hideNoInventoryView
                self.inventoryTableView.isHidden = !hideNoInventoryView
                self.inventoryTableView.reloadData()
        }
    }
    
    //MARK:AddInventoryViewControllerDelegate
    func addInventoryViewController(_ controller: AddInventoryViewController,
                                    didAddNewInventory inventory: DSInventory)
    {
        self.inventories.inventories.append(inventory)
        self.reloadInventories()
    }
    
    func addInventoryViewController(_ controller: AddInventoryViewController,
                                    updatedInventory inventory: DSInventory)
    {
        //update inventory logic
    }
    
    //MARK:Private Methods

    private func loadInventories()
    {
        let page:Int = 1
        let endpoint = Endpoint.inventory + "/?page1" //+ String(page)
                
        APIManager.shared.makeAPIRequest(ofType: MethodType.get,
                                         withEndpoint:endpoint,
                                         andParam:nil,
                                         shouldAuthenticate: true,
                                         showHUD: true)
        { (responseDict, error)  in
            
            if error != nil
            {
                Utilities.showAlertWithMessage(message: error?.localizedDescription ?? DEFAULT_ERROR_STRING,
                                               controller: self)
            }
            else
            {
                guard let dictionary = responseDict,
                    let records = dictionary.object(forKey: Key.results) as? [NSDictionary]
                    else {return}
                
                var arrInventories = [DSInventory]()
                
                for record in records
                {
                    let inventory = DSInventory.init(fromDictionary: record as! [String:Any])
                    arrInventories.append(inventory)
                }
                
                self.inventories.inventories = arrInventories
                
                self.reloadInventories()
                
            }
        }
    }
    
    private func getInventoryTypes()
    {
        APIManager.shared.makeAPIRequest(ofType: MethodType.get,
                                         withEndpoint: Endpoint.inventoryType,
                                         andParam: nil,
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
                    
                    User.currentUser.inventoryTypes = [String:String]()
                    User.currentUser.inventoryTypes?[id] = name
                    
                }
                
                self.reloadInventories()
            }
        }
    }
    
    private func setupTableView()
    {
        DispatchQueue.main.async {
            
            self.inventoryTableView.dataSource = self
            self.inventoryTableView.delegate = self
            self.inventoryTableView.rowHeight = 140
            self.inventoryTableView.separatorStyle = .none
            
        }
    }
    
    private func getInventroryrryTypeNameForId(_ strId:String) -> String
    {
        var name = "Unknown Inventory"
        
        if let inventoryTypesDict = User.currentUser.inventoryTypes
        {
            if let typeName = inventoryTypesDict[strId]
            {
                name = typeName
            }
        }
        
        return name
    }
    
    private func imageForInventoryType(_ strInventoryType:String) -> UIImage?
    {
        var image:UIImage? = nil
        var strImageName:String? = nil
        
        switch strInventoryType
        {
        case "Dog":
            strImageName = "dogIcon"
           
        case "Cat":
            strImageName = "catIcon"
            
        default:
            strImageName = "catIcon"
        }
        
        image = UIImage.init(named: strImageName!)
        
        return image
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddInventoryViewController"
        {
            let vc = segue.destination as! AddInventoryViewController
            vc.delegate = self
        }
        
        if segue.identifier == "InventoryDetailViewController"
        {
            let vc = segue.destination as! InventoryDetailViewController
            vc.inventory = self.inventories.inventories[self.selectedIndex!]
        }
    }
    

}
