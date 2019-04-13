//
//  SignUpViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 01/01/01.
//  Copyright © 2001 SS Incorporation. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    private var userTypes:[String:String]!
    
    //MARK:Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getUserTypes()
    }
    
    //MARK:IBActions
    
    @IBAction func onSignup(_ sender: Any)
    {
        if let name = self.textFieldName.text,
            name != ""
        {
            if let email = self.textFieldEmail.text,
                Utilities.isValidEmail(strMial: email)
            {
                if let password = self.textFieldPassword.text,
                password != ""//need a valid password method
                {
                    self.signUpWith(name: name,
                                    email: email,
                                    andPassword: password)
                }
                else
                {
                    Utilities.showAlertWithMessage(message: "Invalid Password",
                                                   controller: self)
                }
            }
            else
            {
                Utilities.showAlertWithMessage(message: "Invalid Email",
                                               controller: self)
            }
        }
        else
        {
            Utilities.showAlertWithMessage(message: "Invalid Name",
                                           controller: self)
        }
        
    }
    
    @IBAction func onLogin(_ sender: Any)
    {
        //navigate to login screen
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:Private Methods
    
    private func getUserTypes()
    {
        APIManager.shared.makeAPIRequest(ofType: MethodType.get,
                                         withEndpoint: Endpoint.userTypes,
                                         andParam: nil,
                                         shouldAuthenticate: false,
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
                
                self.userTypes = [String:String]()
                
                let userTypes = dictionary.object(forKey: Key.records) as? [NSDictionary] ?? [NSDictionary]()
                
                for user in userTypes
                {
                    guard
                        let id = user.object(forKey: Key.id) as? String,
                        let name = user.object(forKey: Key.name) as? String
                        
                        else
                    {return}
                    
                    self.userTypes[name] = id
                    
                }
            }
        }
    }
    
    private func signUpWith(name strName:String,
                    email strEmail:String,
                    andPassword strPwd:String)
    {
        let userType = self.userTypes[User.currentUser.userTypeKey] ?? ""
        let signupType = "0"
        let socialToken = strPwd
        
        let dict = NSDictionary.init(objects:[strEmail,
                                              strName,
                                              strPwd,
                                              signupType,
                                              userType,
                                              socialToken],
                                     
                                     forKeys:[Key.email as NSCopying,
                                              Key.name as NSCopying,
                                              Key.password as NSCopying,
                                              Key.signupType as NSCopying,
                                              Key.userType as NSCopying,
                                              Key.socialToken as NSCopying])
        
        APIManager.shared.makeAPIRequest(ofType: MethodType.post,
                                         withEndpoint: Endpoint.signup,
                                         andParam: dict,
                                         shouldAuthenticate: false,
                                         showHUD: true)
        { (responseDict,error)  in
            
            if error != nil
            {
                Utilities.showAlertWithMessage(message: error?.localizedDescription ?? DEFAULT_ERROR_STRING,
                                               controller: self)
            }
            else
            {
                guard let dictionary = responseDict,
                    let status = dictionary.object(forKey: Key.status) as? Int,
                    status == 201
                    else{return}
                
                User.currentUser.sessionToken = dictionary.object(forKey: Key.token) as! String?
                User.currentUser.name = dictionary.object(forKey: Key.name) as! String?
                User.currentUser.email = dictionary.object(forKey: Key.email) as! String?
                
                let inventoryVC = InventoriesViewController.init()
                inventoryVC.isNewSignup = true
                
                
                //                    Utilities.showAlertWithMessage(message: message,
                //                                                   animated: true,
                //                                                   controller: self,
                //                                                   completionHandler:
                //                        {
                //
                DispatchQueue.main.async
                    {
                        self.performSegue(withIdentifier:"InventoriesViewController",
                                          sender:nil)
                }
                //                    })
                
            }
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        if segue.identifier == "InventoriesViewController"
        {
            let inventoryVC = segue.destination as! InventoriesViewController
            
            inventoryVC.isNewSignup = true
        }
    }
 

}
