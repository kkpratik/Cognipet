//
//  Utilities.swift
//  GHC
//
//  Created by Apple on 07/02/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
//import FBSDKCoreKit
//import FBSDKLoginKit

class Utilities: NSObject
{
    static func isValidEmail(strMial:String) -> Bool
    {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: strMial, options: [], range: NSRange(location: 0, length: strMial.count)) != nil
    }
    
    static func isValidPassword(strPassword:String) -> Bool
    {
        if strPassword != ""
        {
            return true
        }
        
        return false
//        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
//        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: strPassword)
    }
    
    static func isValidString(_ string:String?) -> Bool
    {
        guard let str = string, str.count > 0
        else {
            return false
        }
        
        return true
    }
    
    

//{
//
//    static let ref : DatabaseReference = Database.database().reference()
//    static let userFacebookID = getUserDefaultForKey("user_facebook_id") as? String
//    static let currentUserName = getUserDefaultForKey("current_user_name") as? String
//    static public var isUserExist : Bool?
//    static fileprivate let ghcDateFromate = "yyyy-MM-dd"
//
//    static func isUserIdExistOnFirebase() -> Void {
//
//        var handler : DatabaseHandle!
//        if userFacebookID != nil {
//             handler =  ref.child("users").child(self.userFacebookID!).observe(DataEventType.value) { (snapshot) in
//                if snapshot.exists() {
//                    print("utilities user exist")
//                    isUserExist = true
//                    Utilities.removeObjectForKey(key: "default_message_loaded")
//                    let userdata = snapshot.value as! [ String  : Any ]
//                    let personalData = userdata["personal_info"] as! [ String : Any ]
//                    var notificationStatus = "high"
//                    if personalData["notification_status"] != nil {
//
//                        notificationStatus = personalData["notification_status"] as! String
//                    }
//                    Utilities.setUserDefaultWithObject(object: notificationStatus, key: "notification_status")
//
//                }
//                else {
//                    print("user does not exist")
//                    isUserExist = false
//                }
//            }
//            self.ref.removeObserver(withHandle: handler)
//        }
//        else {
//            isUserExist = false
//            print("No user available")
//        }
////        Utilities.setUserDefaultWithObject(object: true, key: "default_message_loaded")
//    }
//    static func getGreetingQuotes() -> [Any] {
//
//        var marrGreetings = [Any]()
//        let arrData = self.getUserDefaultForKey("greeting_quotes") as? Data
//        if arrData != nil {
//
//            let tempArr = NSKeyedUnarchiver.unarchiveObject(with: arrData! ) as! [Any]
//            marrGreetings = tempArr
//        }
//        else {
//
//            var handler : DatabaseHandle!
//            handler =  ref.child("greetingQuote").observe(.value) { (snapshot) in
//
//                if snapshot.exists() {
//
//                    let temp = snapshot.value as! NSArray
//                    let arr = NSKeyedArchiver.archivedData(withRootObject: temp)
//                    self.setUserDefaultWithObject(object: arr, key: "greeting_quotes")
//                    marrGreetings = temp as! [Any]
//                    AppDelegate.shared().marrGreetings = NSMutableArray.init(array: temp)
//                }
//
//                self.ref.removeObserver(withHandle: handler)
//            }
//        }
//        return marrGreetings
//    }
//
//    static func BG(_ block: @escaping ()->Void) {
//        DispatchQueue.global(qos: .default).async(execute: block)
//    }
//
//    static func UI(_ block: @escaping ()->Void) {
//        DispatchQueue.main.async(execute: block)
//    }
//    static func getRandomBotQuestion() -> String {
//
//        let randomQuestion = [ "Are you feeling happier? ","Are you feeling happier? ","Are you feeling happier? ","Are you feeling happier? " ]
//        let randomElement = Int(arc4random_uniform(UInt32(randomQuestion.count)))
//        return randomQuestion[randomElement]
//    }
//    static func getUserDefaultForKey(_ key: String) -> Any! {
//
//        return UserDefaults.standard.value(forKey:key) as Any
//    }
//    static func setUserDefaultWithObject(object: Any, key: String) -> Void {
//
//        UserDefaults.standard.set(object, forKey: key)
//    }
//    static func removeObjectForKey(key: String) -> Void {
//
//        UserDefaults.standard.removeObject(forKey: key)
//    }
//
//    static func removeAllUserDefaults() {
//
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removeVolatileDomain(forName: domain)
//        UserDefaults.standard.synchronize()
//    }
//
//    static func getDateFromString(_ string :String) -> Date? {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = ghcDateFromate
//        return dateFormatter.date(from: string)
//    }
//
//    static func getStringFromDate(_ date :Date ) -> String {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = ghcDateFromate
//        return dateFormatter.string(from: date)
//    }
       static func showAlertWithMessage( message :String,
                                      controller :UIViewController) -> Void
    {
        let alert = UIAlertController(title:"",
                                      message : message,
                                      preferredStyle : .alert)
        
        alert.addAction(UIAlertAction(title:"OK",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        
        controller.present(alert,
                           animated: true,
                           completion: nil)
    }

    static func showAlertWithMessage(message:String,
                                     animated:Bool,
                                     controller :UIViewController,
                                     completionHandler: @escaping () -> Void)
    {
        let alert = UIAlertController(title:"",
                                      message : message,
                                      preferredStyle : .alert)
        
         let action = UIAlertAction.init(title: "Ok",
                           style: UIAlertAction.Style.default)
        { (actionType) in
            
            completionHandler()
        }
        
        alert.addAction(action)
        
    
        DispatchQueue.main.async
            {
                controller.present(alert,
                                   animated: animated)
        
        
        }
    }
    
//
//    static func resetDefaults() -> Void {
//
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
//    }
//
////    static func setRootController() -> Void {
////
////        let storyBoard : UIStoryboard  = UIStoryboard(name:"Main", bundle: nil)
////        let sideMenuVC : SideMenuVC = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
////        var frontVC : UIViewController?
////
////        let token = Utilities.getUserDefaultForKey("session_token") as? String ?? ""
////        let userCode = Utilities.getUserDefaultForKey("UserCode") as? String
////        if token != "" {
////            if ( userCode == "ST" ) {
////
////                frontVC = storyBoard.instantiateViewController(withIdentifier: "StudentHomeVC") as! StudentHomeVC
////            }
////            else {
////                frontVC = storyBoard.instantiateViewController(withIdentifier: "ChefsHomeVC") as! ChefsHomeVC
////            }
////        }
////        else {
////             frontVC  = storyBoard.instantiateViewController(withIdentifier: "UserSelectionVC") as! UserSelectionVC
////        }
////
////        let swReveal = SWRevealViewController.init(rearViewController: sideMenuVC, frontViewController: Utilities.getNavigationVC(frontVC!))
////
////        AppDelegate.shared().window?.rootViewController = swReveal
////        AppDelegate.shared().window?.makeKeyAndVisible()
////    }
//
//    static func showHUDWithGIFName(name : String, withBGImage : UIImage) {
//
//        GIFHUD.shared.shouldAddBG = true
//        GIFHUD.shared.setGif(named: name)
//        GIFHUD.shared.hudBGImage = withBGImage
//        GIFHUD.shared.show(withOverlay: true, duration: 0)
//    }
//    static func dismissGIFHUD() {
//        GIFHUD.shared.dismiss()
//    }
//    static func showLoader(_ onView : UIView) -> UIView {
//
//        let loaderView = UIView.init(frame: onView.bounds)
//        loaderView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        let loader = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
//        loader.startAnimating()
//        loader.center = loaderView.center
//        DispatchQueue.main.async {
//             loaderView.addSubview(loader)
//            onView.addSubview(loaderView)
//        }
//            return loaderView
//    }
//
//    static func hideLoader( loader:UIView) {
//        DispatchQueue.main.async {
//            loader.removeFromSuperview()
//        }
//    }
//
//    static func getDayMonthYear( _ strDate : String ) -> [ String : Any ] {
//
//        var mdict = [ String : Any ]();
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let date: Date! = formatter.date(from: strDate)
//        let timeZone = NSTimeZone.local as NSTimeZone
//        formatter.timeZone = timeZone as TimeZone!
//
//        let calendar = Calendar.current
//        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .weekday])
//
//        let components = calendar.dateComponents(unitFlags
//            , from: date!)
//
//        let weekDay = components.weekday!
//        let weekdayName = formatter.weekdaySymbols[weekDay - 1]
//
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "dd"
//        mdict["day"] = newFormatter.string(from: date!)
//
//        newFormatter.dateFormat = "MMM"
//        mdict["month"] = newFormatter.string(from: date!)
//
//        newFormatter.dateFormat = "yyyy"
//        mdict["year"] = newFormatter.string(from: date!)
//
//        mdict["dayname"] = weekdayName
//
//        return mdict;
//    }
//    static func getDayMonthYearFromCurrentDate() -> [ String : Any ] {
//
//        var mdict = [ String : Any ]();
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let date: Date! = Date()
//        let timeZone = NSTimeZone.local as NSTimeZone
//        formatter.timeZone = timeZone as TimeZone!
//
//        let calendar = Calendar.current
//        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .weekday])
//
//        let components = calendar.dateComponents(unitFlags
//            , from: date!)
//
//        let weekDay = components.weekday!
//        let weekdayName = formatter.weekdaySymbols[weekDay - 1]
//
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "dd"
//        mdict["day"] = newFormatter.string(from: date!)
//
//        newFormatter.dateFormat = "MMM"
//        mdict["month"] = newFormatter.string(from: date!)
//
//        newFormatter.dateFormat = "yyyy"
//        mdict["year"] = newFormatter.string(from: date!)
//
//        mdict["dayname"] = weekdayName
//
//        return mdict;
//    }
//    static func getNavigationVC(_ vc : UIViewController) -> UINavigationController {
//        return UINavigationController.init(rootViewController: vc)
//    }
//
//    static func navigateToUserSelection(_ message : String ) {
//
//        let alert = UIAlertController(title: UserString.appName, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
//            (action : UIAlertAction! ) in
//            Utilities.resetDefaults()
////            Utilities.setRootController()
//        }))
//    }
//
//    static func showAlertWithPop( message : String ,nav : UINavigationController, onView : UIViewController) {
//
//        let alert = UIAlertController(title: UserString.appName, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: UserString.ok, style: .default, handler: {
//            (action : UIAlertAction! ) in
//            nav.popViewController(animated: true)
//        }))
//        onView.present(alert, animated: true, completion: nil)
//    }
//
//    static func getJsonString( _ object : Any ) -> String {
//        let error : Error? = nil
//        let jsonData : Data? = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
//        var jsonSTring : String? = ""
//        if (jsonData != nil) && (error == nil) {
//            jsonSTring = String(data: jsonData!, encoding: .utf8)!
//        }
//        return jsonSTring!
//    }
//
//    static func openUrlInSafari( _ url : String) -> Void {
//
//        let url = URL(string: url)
//        UIApplication.shared.open(url!, options: [ : ], completionHandler: nil)
//    }
//
//    static func makeObjectCircular(_ obj : AnyObject) {
//        obj.layer.cornerRadius = obj.frame.size.width / 2
//        obj.layer.masksToBounds = true
//    }
//
//    static func setCornerRadius(_ obj : AnyObject) {
//        obj.layer.masksToBounds = true
//        obj.layer.cornerRadius = 8.0
//    }
//
//    static func getRandomColor () -> UIColor {
//        let redValue   : CGFloat = CGFloat(drand48())
//        let greenValue : CGFloat = CGFloat(drand48())
//        let blueValue  : CGFloat = CGFloat(drand48())
//        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
//    }
//    static func getSortedArrayByKey(itemsArray : NSArray, byKey: NSString, sortAscending: Bool) -> NSArray {
//
//        let sortedArray = (itemsArray as NSArray).sortedArray(using: [NSSortDescriptor(key: byKey as String, ascending: sortAscending)]) as! [[String:AnyObject]]
//        return sortedArray as NSArray
//    }
//
//    static func popNumberofVC(_ number : Int, _ navigation : UINavigationController) {
//
//        if number <= 1 {
//            navigation.popViewController(animated: true)
//        }
//        else {
//            let controllers = navigation.viewControllers
//            var requiredIndex = controllers.count - number - 1
//            if requiredIndex < 0 {
//                requiredIndex = 0
//            }
//            let vc = controllers[requiredIndex]
//            navigation.popToViewController(vc, animated: true)
//        }
//    }
//
//    static func navigateToVC(_ identifier : String , _ nav : UINavigationController) {
//        let storyBoard = UIStoryboard.init(name: "Main", bundle:Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
//        nav.pushViewController(vc, animated: false)
//
//    }
//
//    static func navigateToVC( identifier : String ,  nav : UINavigationController, withAnimation animation: Bool) {
//        let storyBoard = UIStoryboard.init(name: "Main", bundle:Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
//        nav.pushViewController(vc, animated: animation)
//
//    }
//
//    static func showLoadingView(_ onView : UIViewController, withState state:Bool) {
//
//        let darkView = UIView.init(frame: onView.view.bounds)
//        darkView.backgroundColor = UIColor.black
//        darkView.alpha = 0.7
//
//        let spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
//        spinner.center = onView.view.center
////        onView.view.addSubview([ darkView, spinner])
//
//        if state {
//            UIView.animate(withDuration: 0.3, animations: {
//                darkView.alpha = 0.7
//            }, completion: {_ in
//                darkView.isHidden = false
//                spinner.startAnimating()
//            })
//        }
//        else {
//            UIView.animate(withDuration: 0.3, animations: {
//                darkView.alpha = 0
//            }, completion: { _ in
//                spinner.stopAnimating()
//                darkView.isHidden = true
//            })
//        }
//    }
//
//    static func setLineSpaceToLabel(_ text : String ) -> NSAttributedString {
//        let attributedString = NSMutableAttributedString(string: text)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 1.5
//        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
//        return attributedString
//    }
//
////    static func downloadImageFromURL(_ objectURL : String,  imageView: UIImageView) {
////
////        let imageURL = URL(string: objectURL)
////        let extention = imageURL?.pathExtension
////        URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
////            guard let data = data ,error == nil else { return }
////            DispatchQueue.main.async {
////                if extention != "gif" {
////                    imageView.image = UIImage(data: data)
////                }
////                else {
////                    imageView.image = UIImage.gif(url:objectURL )
////                }
////            }
////        }.resume()
////    }
//
//    static func showG(_ imageURL : String,  imageView: UIImageView) {
//
//        let imageURL = URL(string: imageURL)
//        URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
//            guard let data = data ,error == nil else { return }
//            print("Download Finished")
//            DispatchQueue.main.async {
//                imageView.image = UIImage(data: data)
//            }
//            }.resume()
//    }
//
//    static func showPopupView(_ popupView: UIView?, on viewController: UIViewController?) {
//
//        let overLay = UIView(frame: UIScreen.main.bounds)
//        overLay.backgroundColor = .black
//        overLay.alpha = 0.5
//        overLay.tag = 786
//        popupView?.isHidden = false
//        viewController?.view.addSubview(overLay)
//        if let aView = popupView {
//            viewController?.view.bringSubview(toFront: aView)
//            popupView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.4)
//        }
//        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {() -> Void in
//            popupView?.transform = .identity
//        }) {( cehck) -> Void in}
//    }
//    static func clearTmpDirectory() {
//
////        do {
////            let filemanageerr = FileManager.default
////            let tmpDirectory = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
////            try tmpDirectory.forEach {[filemanageerr] file in
////                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
////                try FileManager.default.removeItem(atPath: path)
////            }
////        } catch {
////            print(error)
////        }
//    }
//    static func removeLocalItemAtURL(_ itemURL : URL) {
//
//        do {
//            try FileManager.default.removeItem(at: itemURL)
//            print("local item removed")
//        }
//        catch {
//            print("local item not removed")
//        }
//    }
//    static func hidePopupView(_ popupView: UIView?, from viewcontroller: UIViewController?) {
//        let overlayView: UIView? = viewcontroller?.view.viewWithTag(786)
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {() -> Void in
//            popupView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
//        }, completion: {(_ finished: Bool) -> Void in
//            popupView?.isHidden = true
//        })
//        overlayView?.removeFromSuperview()
//    }
//
//    static func setColorFromHexCode( hexCode : String ) -> UIColor {
//        var cString:String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//
//        if ((cString.count) != 6) {
//            return UIColor.gray
//        }
//
//        var rgbValue:UInt32 = 0
//        Scanner(string: cString).scanHexInt32(&rgbValue)
//
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
//
//    static func setStatusBarColor() {
//
//        let color =  UIColor.init(red: 255.0/255.0, green: 210.0/255.0, blue: 50.0/255.0, alpha: 1.0)
//        UIApplication.shared.statusBarView?.backgroundColor = color
//        UIApplication.shared.statusBarView?.alpha = 0.9
//    }
////    static func loginWithFacebook(_ viewController : UIViewController, with navigation: UINavigationController) -> Void {
////        let loginManager : FBSDKLoginManager = FBSDKLoginManager()
////        loginManager.logIn(withReadPermissions: ["email"], from: viewController) { (result, error) in
////            if error == nil {
////                let loginResult : FBSDKLoginManagerLoginResult = result!
////
////                // If user cancel the login
////                if ( result?.isCancelled )! {
////                    print("User cancel the facebook login")
////                    return
////                }
////                if ( loginResult.grantedPermissions.contains("email") ) {
////
////                    if ( FBSDKAccessToken.current() != nil ) {
////                        Utilities.setUserDefaultWithObject(object: FBSDKAccessToken.current().tokenString, key: "FacebookToken")
////
////                        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name,email"]).start(completionHandler: { (connection, result, error) in
////
////                        })
////
////                        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name,email,birthday,gender,hometown,picture,first_name,last_name" ]).start(completionHandler: { (connection, result, error) in
////                            if error == nil {
////                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
////                                let signupVC = storyBoard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
////                                signupVC.dictUser = result as? [String : Any]
////                                print(result as? [String : Any] as Any)
////                                signupVC.modalTransitionStyle = .crossDissolve
////                                viewController.present(signupVC, animated: true, completion: nil)
////                            }
////                            else {
////                                Utilities.showAlertWithMessage(message: (error?.localizedDescription)!, controller: viewController)
////                            }
////                        })
////                    }
////                }
////            }
////        }
////    }
//}

//extension Dictionary {
//    subscript(keyPath keyPath: String) -> Any? {
//        get {
//            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath)
//                else { return nil }
//            return getValue(forKeyPath: keyPath)
//        }
//        set {
//            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath),
//                let newValue = newValue else { return }
//            self.setValue(newValue, forKeyPath: keyPath)
//        }
//    }
//    
//    static private func keyPathKeys(forKeyPath: String) -> [Key]? {
//        let keys = forKeyPath.components(separatedBy: ".")
//            .reversed().flatMap({ $0 as? Key })
//        return keys.isEmpty ? nil : keys
//    }
//    
//    // recursively (attempt to) access queried subdictionaries
//    // (keyPath will never be empty here; the explicit unwrapping is safe)
//    private func getValue(forKeyPath keyPath: [Key]) -> Any? {
//        guard let value = self[keyPath.last!] else { return nil }
//        return keyPath.count == 1 ? value : (value as? [Key: Any])
//            .flatMap { $0.getValue(forKeyPath: Array(keyPath.dropLast())) }
//    }
//    
//    // recursively (attempt to) access the queried subdictionaries to
//    // finally replace the "inner value", given that the key path is valid
//    private mutating func setValue(_ value: Any, forKeyPath keyPath: [Key]) {
//        guard self[keyPath.last!] != nil else { return }
//        if keyPath.count == 1 {
//            (value as? Value).map { self[keyPath.last!] = $0 }
//        }
//        else if var subDict = self[keyPath.last!] as? [Key: Value] {
//            subDict.setValue(value, forKeyPath: Array(keyPath.dropLast()))
//            (subDict as? Value).map { self[keyPath.last!] = $0 }
//        }
//    }
}
