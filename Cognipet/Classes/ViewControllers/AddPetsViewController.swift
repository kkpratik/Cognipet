//
//  AddPetsViewController.swift
//  Cognipet
//
//  Created by Kunal Pable on 10/02/19.
//  Copyright © 2019 SS Incorporation. All rights reserved.
//

import UIKit

class AddPetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddPetDetailsCellDelegate
{
    
    
    @IBOutlet weak var petIconImageView: UIImageView!
    
    @IBOutlet weak var motherIdLabel: UILabel!
    @IBOutlet weak var fatherIdLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var birthPlaceTextField: UITextField!
    
    @IBOutlet weak var tableViewPetDetails: UITableView!
    
    private var petList:DSPets = DSPets()
    
    
    //MARK:View LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableViewPetDetails.dataSource = self
        self.tableViewPetDetails.delegate = self
        self.tableViewPetDetails.rowHeight = 310
        
        self.petList.pets?.append(DSPet.init())
    }
    
    //MARK:TableView DataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return self.petList.pets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard  let tempCell = tableView.dequeueReusableCell(withIdentifier: "AddPetDertailsCell"),
            let pet = self.petList.pets?[indexPath.row]
            else {
            return AddPetDertailsCell()
        }
        
        let pCell = tempCell as! AddPetDertailsCell
        pCell.delegate = self
        
        pCell.petNameTextField.text = pet.name
        pCell.microchipIdTextField.text = pet.id
        pCell.ownerNameTextField.text = pet.owner
        pCell.petPriceTextField.text = pet.price
        pCell.setIsAvailable(pet.status == "availabel" ? true : false)
        pCell.setIsMaleGender(pet.gender == "male" ? true : false)
        
        return pCell
    }
    
    //MARK:TableView Delegate
    
    
    //MARK:AddPetDertailsCell Delegate
    
    func petDetailsCell(addNewCellButtonTapped cell: AddPetDertailsCell)
    {
        //update the fill information to pet at index path, in petlist then add a default pet
        self.saveCurrentInformationForCells()
        
        self.petList.pets?.append(DSPet.init())
        
        self.tableViewPetDetails.reloadData()

        self.tableViewPetDetails.scrollToRow(at: IndexPath.init(row: (self.petList.pets?.count)!-1, section: 0)
            , at: .middle,
              animated:true)
    }
    
    func petDetailsCell(deleteCellButtonTapped cell: AddPetDertailsCell)
    {
        if let petsCount = self.petList.pets?.count, petsCount > 1
        {
            if let indexPath = self.tableViewPetDetails.indexPath(for: cell)
            {
                self.petList.pets?.remove(at: indexPath.row)
                
                self.tableViewPetDetails.reloadData()
                
                self.tableViewPetDetails.scrollToRow(at: IndexPath.init(row: indexPath.row - 1, section: indexPath.section),
                                                     at: .middle,
                                                     animated:true)
            }
        }
        else
        {
            self.petList.pets?.removeAll()
            self.petList.pets?.append(DSPet.init())
            self.tableViewPetDetails.reloadData()
        }
    }
    
    //MARK:IBActions
    
    @IBAction func onAddPetButton(_ sender: Any)
    {
        
    }
    
    //MARK:Private methods
    
    private func saveCurrentInformationForCells()
    {
        let pCellCount = self.tableViewPetDetails.numberOfRows(inSection: 0)
        
        for i in 0..<pCellCount
        {
            let indexPath = IndexPath.init(row: i, section: 0)
            if let pCell = self.tableViewPetDetails.cellForRow(at: indexPath) as! AddPetDertailsCell?
            {
                let pet = pCell.getPet()
                self.petList.pets?.remove(at: i)
                self.petList.pets?.insert(pet, at: i)
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
