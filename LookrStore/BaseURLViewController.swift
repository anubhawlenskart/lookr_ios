//
//  BaseURLViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 25/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.


import Foundation
import UIKit


class LookrConstants: NSObject {
    static let sharedInstance = LookrConstants()
    let baseURL  = "http://52.221.75.148/v109/lookr/api/"
    let baseSMS  = "http://52.221.75.148/"
    let color =  UIColor(red:0.33, green:0.73, blue:0.78, alpha:1)
    let bgcolor = UIColor(red:0, green:0.07, blue:0.08, alpha:1)



}
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public var autoClicked:Bool = false

let nameLength  = 25


let baseurl  = "https://labs.lenskart.com/v108/lookr/api/"


//MARK:-
//MARK:- static array


//MARK: - Server Error Message Constants
let error = "Error"
let enter_email = "Please enter email address"
let enter_valid_email = "Please enter valid email address"
let enter_psw = "Please enter password"
let enter_confirm_psw = "Please enter confirm password"
let enter_first_name = "Please enter first name"
let enter_last_name = "Please enter last name"
let enter_full_name = "Please enter full name"
let psw_must_same = "Password and confirm password must be same"
let enter_current_psw = "Please enter current password"
let enter_new_psw = "Please enter new password"
let enter_phone = "Please enter phone number"
let enter_phone_min_max_digit = "Phone number must be minimum 4 digits and maximum 15 digits"
let new_psw_must_same = "New password and confirm password must be same"




let kEmail     = "email"
let kID        = "ID"
let kUserType  = "user_type"
let kUserToken  = "token"
let kLname = "lname"
let kProfilePic = "profile_photo"
let kFname      = "fname"
let KUserName = "username"
let KAddress = "address"
let KPhone = "phone"
let KPwd = "password"
let KPinCode = "pincode"
let KState = "state"
let KCity = "city"
let KCountry = "country"
let KKYCSTATUS = "status"
let KPushToken    = "push_token"
let KGender = "gender"
let KAboutMe  = "about_me"
let KIsAppLaunch  = "KIsAppLaunch"
//MARK:-
//MARK: - Header  TOKEN
struct headerfield {
    
    static let kToken = "token"
    static let kAPIContentType = "Content-Type"
    static let kAPIkAPIContentTypeValue = "application/x-www-form-urlencoded"
    
}

//MARK: - Array

//MARK:-
//MARK: - Side menu

//MARK:-
//MARK: - Service API Constants


/// If google key is empty than location fetch via goecode.

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
