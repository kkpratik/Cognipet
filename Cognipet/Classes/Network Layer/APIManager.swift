//
//  APIManager.swift
//  Cognipet
//
//  Created by ShivamSevarik on 17/12/18.
//  Copyright © 2018 SS Incorporation. All rights reserved.
//

import UIKit
import Foundation

let BASE_URL = "https://cognipet.herokuapp.com/api/v1/"


class APIManager: NSObject, URLSessionDelegate {
    
    static let shared : APIManager = APIManager()
    
    var activityIndicator:ActivityIndicatorHud?
    
    
    func makeAPIRequest(ofType : String,
                        withEndpoint endpoint : String,
                        andParam param : NSDictionary?,
                        shouldAuthenticate authenticate:Bool,
                        showHUD : Bool,
                        completionHandler :  @escaping (_ responseDict:NSDictionary?, _ error:Error?) -> Void)
    {
        
        if showHUD
        {
            self.showActivityIndicatorView()
        }
        
        var headers = [
            "Content-Type": "application/x-www-form-urlencoded",// "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
        ]
        
        var token = ""
        
        if authenticate
        {
            let strToken = (User.currentUser.sessionToken ?? "")
            token =  /*"'" + */Key.token + " " + strToken/* + "'"*/
            
            headers.updateValue(token,
                                forKey: Key.authorization)
            
            headers.removeValue(forKey: "cache-control")
            headers.updateValue("application/json", forKey: "Content-Type")
        }
        
        
        let postData = NSMutableData.init()
        var finalKV:String?
        
        if let keys = param?.allKeys
        {
            
            for key in keys {
                
                finalKV = "&\(key as! String)=\(param?.value(forKey: key as! String) ?? "")"
                
                if let kv = finalKV
                {
                    postData.append(kv.data(using: String.Encoding.utf8)!)
                }
            }
        }
        
        ////////// JSON String
        //let jsonData = try? JSONSerialization.data(withJSONObject: param ?? [:], options: [])
        //let jsonString = String(data: jsonData!, encoding: .utf8)
        
        let strURL = "\(BASE_URL)\(endpoint)/"
        let finalURL = URL.init(string: strURL)
        let request = NSMutableURLRequest(url: finalURL!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = ofType
        request.allHTTPHeaderFields = headers
        
        if let body = finalKV
        {
            request.httpBody = postData as Data
        }
        
        
        print("Token = \(token)\n Header = \(headers)\n FinalURL = \(strURL)\n Param = \(String(describing: param))")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
                                            
                                            if error == nil
                                            {
                                                do {
                                                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: [])
                                                    
                                                    if let dict = jsonResult as? NSDictionary
                                                    {
                                                        print(jsonResult)
                                                        
                                                        completionHandler((dict), error)
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                        
                                                    
                                                    
                                                } catch let error as NSError {
                                                    print(error.localizedDescription)
                                                }
                                            }
                                            else
                                            {
                                                completionHandler((nil), error)
                                            }
        })
        
    
        
        
        
        dataTask.resume()
        
    }
    

    private func showActivityIndicatorView()
    {
        if self.activityIndicator == nil
        {
            var view:UIView!
            
            if let window = UIApplication.shared.windows.first
            {
                let rootViewController = window.rootViewController
                
                if rootViewController is UINavigationController
                {
                    let navigationVC = rootViewController as! UINavigationController
                    let topVC = navigationVC.topViewController
                    view = topVC?.view
                }
                else
                {
                    let topVC  = rootViewController
                    view = topVC?.view
                }
            }
            
            self.activityIndicator = ActivityIndicatorHud.init(frame: view?.frame ?? CGRect())
            self.activityIndicator?.parentView = view
        }
        
        self.activityIndicator?.start()
    }
    
    private func hideActivityIndicatorView()
    {
        if let indicator = self.activityIndicator
        {
            indicator.stop()
        }
    }

}
