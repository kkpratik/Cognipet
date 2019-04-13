//
//  PetDetailViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 16/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class PetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    public var inventory:DSInventory!
    
    @IBOutlet weak var petsTableView: UITableView!
    private var allPets = DSPets()
    var entries = ["Labradore", "German Shephared", "Pug", "Golden Retriver"]

    private var selectPetView:SelectPetView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setUpTableView()
        self.loadAllPetsByUser()
    }
    
    
    //MARK:IBActions
    
    @IBAction func onAddPetButton(_ sender: Any)
    {
        self.showSelecrtPetView()
    }
    
    //MARK:TableView DataSource
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        
        if let pets = self.allPets.pets
        {
            return pets.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:"PetDetailsTableViewCell") as! PetDetailsTableViewCell
        
        let imgName = "img" + String(indexPath.row + 1)
    
        cell.petImage.image = UIImage.init(named: imgName)
        cell.labelPetName.text = imgName
        cell.labelPetAge.text = "14 Weeks"
        cell.labelPetGender.text = "Male"
        cell.labelPetPrice.text = "$200"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            
            //TODO:need to add alert
            
            self.allPets.pets?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let update = UITableViewRowAction(style: .default, title: "Upate") { (action, indexPath) in
            
        }
        
        update.backgroundColor = UIColor.lightGray
        
        return [delete, update]
        
    }
    
    //MARK:TableView Delegate
    
    
    //MARK:Reload Method
    private func reloadAllPets()
    {
        DispatchQueue.main.async {
            
            self.petsTableView.reloadData()
        }
    }
    
    //MARK:Private Methods
    private func setUpTableView()
    {
        self.petsTableView.dataSource = self
        self.petsTableView.delegate = self
        self.petsTableView.rowHeight = 120
    }
    
    
    private func showSelecrtPetView()
    {
        if let pSelectPetView = self.selectPetView
        {
            DispatchQueue.main.async {
                
                pSelectPetView.frame =  self.view.bounds
                
                self.view.addSubview(pSelectPetView)
            }
        }
        else
        {
            let pView =  UINib(nibName: "SelectPetView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SelectPetView
            
            pView.frame = self.view.bounds
            
            pView.executeBlockOnSelection { (selectedPetType) in
                
                if let view = self.selectPetView
                {
                    if view.superview == self.view
                    {
                        view.removeFromSuperview()
                    }
                }
                
                self.performSegue(withIdentifier: "FormDretailsViewController", sender: selectedPetType)
                
            }
            
            self.selectPetView = pView
            
            DispatchQueue.main.async {
                
                self.view.addSubview(pView)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        if segue.identifier == "FormDretailsViewController"
        {
            let navController = segue.destination as! UINavigationController
            let formDetailVC = navController.topViewController as! FormDretailsViewController
            
            formDetailVC.isUsedForFatherDetails = true
            formDetailVC.petType = sender as! PetType?
            
        }
    }
    
    //MARK:API calls
    
    private func loadAllPetsByUser()
    {
//        let page:Int = 1
        let endpoint = Endpoint.products + "/?page1" //+ String(page)
        
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
                    else{return}
                var arrPets = [DSPet]()
                
                for record in records
                {
                    let pet = DSPet.init(fromDictionary: record as! [String:Any])
                    arrPets.append(pet)
                }
                
                self.allPets.pets = arrPets
                
                self.reloadAllPets()
            }
        }
    }

}
