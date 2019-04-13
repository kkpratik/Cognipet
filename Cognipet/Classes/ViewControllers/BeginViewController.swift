//
//  BeginViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 15/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit

class BeginViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPetLover(_ sender: Any)
    {
        User.currentUser.userTypeKey = UserTypeKey.petLover
        self.moveToLoginViewController()
    }
    
    @IBAction func onPetBreeder(_ sender: Any)
    {
        User.currentUser.userTypeKey = UserTypeKey.petBreeder
        self.moveToLoginViewController()
    }
    
    private func moveToLoginViewController()
    {
        self.performSegue(withIdentifier: "ViewController",
                          sender: nil);
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
