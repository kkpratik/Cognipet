//
//  InventoryDetailViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 16/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class InventoryDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var inventoryDetailCollectionView: UICollectionView!
    
    private var pets = DSPets()
    public var inventory:DSInventory!
    var entries = ["Labradore", "German Shephared", "Pug", "Golden Retriver"]
    
    //MARK:Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.setupCollectionView()
//        self.getAllPetsForInventoryId(strId: self.inventory.id)
        
    }
    
    //MARK:CollectionView Datasource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return self.entries.count//self.pets.pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifire = "InventoryDetailCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire,
                                                      for:  indexPath) as! InventoryDetailCollectionViewCell
        
//        let pet = self.pets.pets[indexPath.row]
        
        let imgName = "img" + String(indexPath.row + 1)
        cell.cellBackgroundImageView.image = UIImage.init(named: imgName)
        cell.cellTitleLabel.text = self.entries[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let totalWidth = collectionView.bounds.size.width
        let spacing = 25 * 3 //3 spacing for left, right and middle
        let remainingWidth = totalWidth - CGFloat(spacing)
        let cellWidth = remainingWidth/2 //sinc we display only two cells in a row
        
        return CGSize.init(width: cellWidth,
                           height:  cellWidth)
    }
    
    //MARK:CollectionView Delegate
    
    
    //MARK:IBActions
    @IBAction func onAddMorePets(_ sender: Any)
    {
        
    }
    
    //MARK:Reload Method
    private func reloadPets()
    {
        self.inventoryDetailCollectionView.reloadData()
    }
    
    //MARK:Private Methods
    
    private func setupCollectionView()
    {
        self.inventoryDetailCollectionView.dataSource = self
        self.inventoryDetailCollectionView.delegate = self
    }
    
    private func getAllPetsForInventoryId(strId:String)
    {
        
        APIManager.shared.makeAPIRequest(ofType: MethodType.get,
                                         withEndpoint:Endpoint.productsByInventoryId,
                                         andParam:nil,
                                         shouldAuthenticate:true,
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
                var arrPets = [DSPet]()
                
                for record in records
                {
                    let pet = DSPet.init(fromDictionary: record as! [String: Any])
                    arrPets.append(pet)
                }
                
                self.pets.pets = arrPets
                
                self.reloadPets()
                
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
