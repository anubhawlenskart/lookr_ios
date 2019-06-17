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
                    let urlstring = "https://labs.lenskart.com/v108/lookr/api/register?mobile=\(intnumebr)&apptype=store"
    
                    let params = ["":""] as Dictionary<String, String>
                    
                    var request = URLRequest(url: URL(string: urlstring)!)
                    request.httpMethod = "POST"
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")

                    let session = URLSession.shared
                    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                        do {
                            let str = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>

                            if let nestedDictionary = str["success"] as? [String: Any] {
                                // access nested dictionary values by key
                                for (key, value) in nestedDictionary {
                                    // access all key / value pairs in dictionary
                                    print(key)
                                    print(value)
                                    self.loginOtp()
                                }
                            }
                           
                            
                        } catch {
                            print("error")
                        }
                    })
                    
                    task.resume()
                
                
            }
        
            }
            
            
        }
        
        
    }
    
    func loginOtp(){
        if let numebr = mobileNumber.text {
            if let intnumebr = Int(numebr){
                let urlstring = "https://labs.lenskart.com/v108/lookr/api/login?mobile=\(intnumebr)&&apptype=store&otp=1111"
                
                let params = ["":""] as Dictionary<String, String>
                
                var request = URLRequest(url: URL(string: urlstring)!)
                request.httpMethod = "POST"
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                    do {
                        let str = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        
                        if let nestedDictionary = str["success"] as? [String: Any] {
                            // access nested dictionary values by key
                            for (key, value) in nestedDictionary {
                                // access all key / value pairs in dictionary
                                print(key)
                                print(value)
                                                         
                                let storyBoard : UIStoryboard = UIStoryboard(name: "DittoView", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DittoView") as! DittoViewController
                                self.present(nextViewController, animated:true, completion:nil)
                            }
                        }
                        
                        
                    } catch {
                        print("error")
                    }
                })
                
                task.resume()
        
            }
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.topImageView.image = UIImage.gif(name: "jeremy")
    
        
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
    
    
    
}


@IBDesignable class MyButton: UITextField{
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





