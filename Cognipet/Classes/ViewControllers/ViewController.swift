//
//  ViewController.swift
//  Cognipet
//
//  Created by ShivamSevarik on 05/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBAction func onForgotPassword(_ sender: UIButton)
    {
        
    }
    
    @IBAction func onLogin(_ sender: UIButton)
    {
        let username = self.textFieldUserName.text ?? ""
        if Utilities.isValidEmail(strMial: username)
        {
            let password = self.textFieldPassword.text ?? ""
            if Utilities.isValidPassword(strPassword: password)
            {
                self.loginWithUsername(username: username,
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
    
    @IBAction func onSigunUp(_ sender: UIButton)
    {
        //direct seague is applied from storyboard to signup screen
    }
    
    //TODO:move this in utilty class
    
    private func loginWithUsername(username:String,
                                   andPassword password:String)
    {
        let dict = NSDictionary.init(objects: [username, password],
                                     forKeys: [Key.email as NSCopying,
                                               Key.password as NSCopying])
        
        APIManager.shared.makeAPIRequest(ofType: MethodType.post,
                                         withEndpoint: Endpoint.login,
                                         andParam:dict,
                                         shouldAuthenticate: false,
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
                        let status = dictionary.object(forKey: Key.status) as? Int,
                        status == 200
                        else{return}
                    
                    User.currentUser.sessionToken = dictionary.object(forKey: Key.token) as! String?
                    User.currentUser.name = dictionary.object(forKey: Key.name) as! String?
                    User.currentUser.email = dictionary.object(forKey: Key.email) as! String?
                    
                    //                        let message = responseDict.object(forKey: Key.message) as! String
                    
                    DispatchQueue.main.async
                        {
                            self.performSegue(withIdentifier:"InventoriesViewController",
                                              sender:self)
                    }
                    
                    
                    
                }
                
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        if segue.identifier == "InventoriesViewController"
        {
            let loginVC = segue.destination as! InventoriesViewController
            loginVC.isNewSignup = false
        }
    }
    
}

