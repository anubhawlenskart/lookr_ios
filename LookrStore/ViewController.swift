//
//  ViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 06/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtMobileNo: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.topImageView.image = UIImage.gif(name: "jeremy")

    }

    @IBAction func btnLoginDidClick(_ sender: Any) {
        performSegue(withIdentifier: "HomeViewController", sender: self)

    }
    
}


@IBDesignable class MyButton: UITextField
{
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


