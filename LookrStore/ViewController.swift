//
//  ViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 06/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
    
<<<<<<< HEAD
    @IBOutlet weak var txtMobileNo: UITextField!
    
    @IBOutlet var txtField: UITextField!

   
    @IBAction func getStarted(_ sender: Any) {
        
        
        
    }
    
  
    @IBOutlet var image: UIImageView!
    
    var counter = 1
    
    @IBAction func next(_ sender: AnyObject) {
    
    image.image = UIImage(named: "frame_\(counter)_delay-0.1s.gif")
    
    counter += 1
    
    if counter == 6 {
    
    counter = 0

    }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.topImageView.image = UIImage.gif(name: "jeremy")
        let url = URL(string: "https://labs.lenskart.com/v108/lookr/api/")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // URLSession.shared().dataTask(with: url) { (data, response, error) is now URLSession.shared.dataTask(with: url) { (data, response, error)
=======
    @IBOutlet weak var mobileNumber: UITextField!

    @IBAction func getStarted(_ sender: Any) {

        if mobileNumber.text == "" {
>>>>>>> baf58ecf7418baa6f34c10de6843cd0a090a9d6e
            
            let alert = UIAlertController(title: "Error", message: "Enter Mobile Number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style : .default , handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else {
            
            if let numebr = mobileNumber.text {
                
                if let intnumebr = Int(numebr){
            
                    let urlstring = "https://labs.lenskart.com/v108/lookr/api/register?mobile=\(intnumebr)&apptype=mobile"
                    
                    let url = URL(string: urlstring)!
                    let request = URLRequest(url: url)
                    print(request)
                    let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                    
                        if error != nil {
                            
                            print(error!)
                            
                        } else {
                            
                            if let urlContent = data {
                                
                                do {
                                    
                                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                    
                                    print(jsonResult)
                                    
                                    print(jsonResult["name"])
                                    
                                    if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                        
                                        print(description)
                                        
                                    }
                                    
                                    
                                } catch {
                                    
                                    print("JSON Processing Failed")
                                    
                                }
                                
                            }
                        }
                }
                    task.resume()

                
            }
        
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





