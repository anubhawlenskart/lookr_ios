//
//  GlobelFunctions.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 20/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit
import CoreData
import EventKit

var alertView:UIAlertController = UIAlertController()
class CustomGesture: UITapGestureRecognizer {
    var indexPath:IndexPath? = nil
}
class GlobelFunctions: NSObject {
    
    class  func showAlert(title : String , message: String) -> Void {
        alertView = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler:{(alert: UIAlertAction!) in
            
        }))
    }
    
    
    class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    class  func isKeyPresentInUserDefaults(key: String) -> Bool {
        
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    
    // Mark : Clear UserDefaults Values
    
    
    class func getTintedImage(imageName:String) -> UIImage {
        let origImage = UIImage(named: imageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        return tintedImage!
    }
    class func zoomImage(viewController: UIViewController , imageView: UIImageView){
        
    }
    class func gotoHome() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNavController:UINavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
        
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionFlipFromRight, animations: {UIApplication.shared.keyWindow?.rootViewController = homeNavController}, completion: nil)
        
    }
}





