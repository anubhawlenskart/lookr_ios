//
//  ViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 06/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var maleButton: RoundedCornerView!
    @IBOutlet weak var femaleButton: UIButton!
    var dittoid = "" ,token = ""
    @IBOutlet weak var mobileNumber: UITextField!
    
    @IBAction func getStarted(_ sender: Any) {
        
        if mobileNumber.text == "" {
            
            let alert = UIAlertController(title: "Error", message: "Enter Mobile Number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style : .default , handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else {
            
            if let numebr = mobileNumber.text {
                
                if let intnumebr = Int(numebr){
                    let urlstring = "\(LookrConstants.sharedInstance.baseURL)register?mobile=\(intnumebr)&apptype=store"
                    
                    let params = ["":""] as Dictionary<String, String>
                    
                    var request = URLRequest(url: URL(string: urlstring)!)
                    request.httpMethod = "POST"
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    let session = URLSession.shared
                    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                        DispatchQueue.main.async {
                            if(data != nil){
                                do {
                                    let str = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String, AnyObject>
                                    
                                    if let nestedDictionary = str?["success"] as? [String: Any] {
                                        // access nested dictionary values by key
                                        for (key, value) in nestedDictionary {
                                            // access all key / value pairs in dictionary
                                            print(key)
                                            print(value)
                                        }
                                        
                                        self.loginOtp()
                                    }
                                    
                                    
                                } catch {
                                    print("error")
                                }
                            
                            }
                            
                        }
                    })
                    
                    task.resume()
                    
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    @IBAction func maleButtonAction(_ sender: UIButton) {
    }
    
    
    @IBAction func femaleButtonAction(_ sender: UIButton) {
    }
    
    func loginOtp(){
        if let numebr = mobileNumber.text {
            if let intnumebr = Int(numebr){
                let urlstring = "\(LookrConstants.sharedInstance.baseURL)login?mobile=\(intnumebr)&apptype=store&otp=1111"
                
                let params = ["":""] as Dictionary<String, String>
                
                var request = URLRequest(url: URL(string: urlstring)!)
                request.httpMethod = "POST"
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                    DispatchQueue.main.async {
                        do {
                            let str = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                            
                            if let nestedDictionary = str["success"] as? [String: Any] {
                                // access nested dictionary values by key
                                let defaults = UserDefaults.standard
                                for (key, value) in nestedDictionary {
                                    // access all key / value pairs in dictionary
                                    if key == "dittoid" {
                                        self.dittoid = value as! String
                                        let defaults = UserDefaults.standard
                                        defaults.set(value , forKey: "dittoid")
                                    }
                                    if key == "token" {
                                        let defaults = UserDefaults.standard
                                        defaults.set(value , forKey: "token")
                                    }
                                }
                                
                                defaults.set(numebr , forKey: "mobileno")
                                
                                if(self.dittoid == ""){
                                    self.profileOtp()
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "dittoui") as! DittoViewController
                                    //self.present(balanceViewController, animated: true, completion: nil)
                                    self.navigationController?.pushViewController(balanceViewController, animated: true)
                                    
                                }else{
                                    
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "wishlistui") as! WishlistViewController
                                    // self.present(balanceViewController, animated: true, completion: nil)
                                    self.navigationController?.pushViewController(balanceViewController, animated: true)
                                    
                                    
                                }
                                
                            }
                            
                            
                        } catch {
                            print("error")
                        }
                    }
                })
                
                task.resume()
                
            }
        }
        
    }
    
    
    
    func profileOtp(){
        if let numebr = mobileNumber.text {
            if let intnumebr = Int(numebr){
                let urlstring = "\(LookrConstants.sharedInstance.baseURL)updateprofile?mobile=\(intnumebr)&name=&gender=&age==16-25"
                
                let params = ["":""] as Dictionary<String, String>
                
                var request = URLRequest(url: URL(string: urlstring)!)
                request.httpMethod = "POST"
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                    DispatchQueue.main.async {
                        do {
                            let str = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                            
                            if let nestedDictionary = str["success"] as? [String: Any] {
                                // access nested dictionary values by key
                                let defaults = UserDefaults.standard
                                
                            }
                            
                            
                        } catch {
                            print("error")
                        }
                    }
                })
                
                task.resume()
                
            }
        }
        
    }
    //@IBOutlet var image: UIImageView!
    
    @IBOutlet weak var image: UIImageView!
    var counter = 1
    
    
    var isAnimating = false
    
    var timer = Timer()
    
    @objc func animate() {
        
        image.image = UIImage(named: "katimages.imageset/frame_\(counter)_delay-0.08s.gif")
        
        counter += 1
        
        if counter == 31 {
            
            counter = 0
            
            
        }
        
    }
    
    
    @IBAction func next(_ sender: AnyObject) {
        
        
        if isAnimating {
            
            timer.invalidate()
            //nextbutton.setTitle("Start Animation", for: [])
            isAnimating = true
            
        } else {
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
            animate()
            //nextbutton.setTitle("Stop Animation", for: [])
            
            isAnimating = true
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNumber.becomeFirstResponder()
        mobileNumber.delegate = self
        if isAnimating {
            
            timer.invalidate()
            //nextbutton.setTitle("Start Animation", for: [])
            isAnimating = true
            
        } else {
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
            animate()
            //nextbutton.setTitle("Stop Animation", for: [])
            
            isAnimating = true
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count >= 10 {
            return false
        }
        return true
    }
}



@IBDesignable class MyButton: UITextField{
    
    func removeBorder(_ show: Bool) {
        if show {
            self.layer.borderWidth = borderWidth

        }
        else {
            self.layer.borderWidth = 0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
    }
    
    func updateCornerRadius(radius:CGFloat) {
        layer.cornerRadius = radius
    }
    @IBInspectable var cornerRadius:CGFloat = 0{
        didSet{
            updateCornerRadius(radius: cornerRadius)
        }
    }
}


@IBDesignable
class RoundedCornerView: UIButton {
    
    var cornerRadiusValue : CGFloat = 0
    var corners : UIRectCorner = []
    
    @IBInspectable public var cornerRadius:CGFloat {
        get {
            return cornerRadiusValue
        }
        set {
            cornerRadiusValue = newValue
        }
    }
    
    @IBInspectable public var topLeft : Bool {
        get {
            return corners.contains(.topLeft)
        }
        set {
            setCorner(newValue: newValue, for: .topLeft)
        }
    }
    
    @IBInspectable public var topRight : Bool {
        get {
            return corners.contains(.topRight)
        }
        set {
            setCorner(newValue: newValue, for: .topRight)
        }
    }
    
    @IBInspectable public var bottomLeft : Bool {
        get {
            return corners.contains(.bottomLeft)
        }
        set {
            setCorner(newValue: newValue, for: .bottomLeft)
        }
    }
    
    @IBInspectable public var bottomRight : Bool {
        get {
            return corners.contains(.bottomRight)
        }
        set {
            setCorner(newValue: newValue, for: .bottomRight)
        }
    }
    
    func setCorner(newValue: Bool, for corner: UIRectCorner) {
        if newValue {
            addRectCorner(corner: corner)
        } else {
            removeRectCorner(corner: corner)
        }
    }
    
    func addRectCorner(corner: UIRectCorner) {
        corners.insert(corner)
        updateCorners()
    }
    
    func removeRectCorner(corner: UIRectCorner) {
        if corners.contains(corner) {
            corners.remove(corner)
            updateCorners()
        }
    }
    
    func updateCorners() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadiusValue, height: cornerRadiusValue))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

@IBDesignable
extension UITextField {
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
}



