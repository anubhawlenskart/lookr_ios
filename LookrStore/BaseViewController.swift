//
//  BaseViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 20/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit
import SystemConfiguration

class BaseViewController: UIViewController {
    
    var alert: UIAlertController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        //for change title color of navigation bar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showAlertWithOutOk(title : NSString , message: NSString) -> Void {
        alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        self.perform(#selector(BaseViewController.hide), with: nil, afterDelay: 1.5)
        
    }
    
    @objc func hide() -> Void {
        alert.dismiss(animated: true, completion: nil)
        
    }
    
}

extension UIViewController {
    func customActivityIndicator(view: UIView, widthView: CGFloat?,backgroundColor: UIColor?, textColor:UIColor?, message: String?) {
        
        //Config UIView
        self.view.backgroundColor = backgroundColor //Background color of your view which you want to set
        
        var selfWidth = view.frame.width
        if widthView != nil{
            selfWidth = widthView ?? selfWidth
        }
        
        let selfHeigh = view.frame.height
        let loopImages = UIImageView()
        let image = UIImage(named: "ic_launcher-web")
        var imageListArray = [UIImage]()// Put your desired array of images in a specific order the way you want to display animation.
        imageListArray.append(image!)
        loopImages.animationImages = imageListArray
        loopImages.animationDuration = TimeInterval(0.8)
        loopImages.startAnimating()
        
        let imageFrameX = (selfWidth / 2) - 30
        let imageFrameY = (selfHeigh / 2) - 60
        var imageWidth = CGFloat(60)
        var imageHeight = CGFloat(60)
        
        if widthView != nil{
            imageWidth = widthView ?? imageWidth
            imageHeight = widthView ?? imageHeight
        }
        
        //ConfigureLabel
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
       // label.font = UIFont(name: "SFUIDisplay-Regular", size: 17.0)! // Your Desired UIFont Style and Size
        label.numberOfLines = 0
        label.text = message ?? ""
        label.textColor = textColor ?? UIColor.clear
        
        //Config frame of label
        let labelFrameX = (selfWidth / 2) - 100
        let labelFrameY = (selfHeigh / 2) - 10
        let labelWidth = CGFloat(200)
        let labelHeight = CGFloat(70)
        
        // Define UIView frame
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height)
        
        
        //ImageFrame
        loopImages.frame = CGRect(x: imageFrameX, y: imageFrameY, width: imageWidth, height: imageHeight)
        
        //LabelFrame
        label.frame = CGRect(x: labelFrameX, y: labelFrameY, width: labelWidth, height: labelHeight)
        
        //add loading and label to customView
        view.addSubview(loopImages)
        view.addSubview(label)
    }
    
    func hideLoader(removeFrom : UIView){
        removeFrom.subviews.last?.removeFromSuperview()
        removeFrom.subviews.last?.removeFromSuperview()
    }
    
    func showLoader() {
        self.customActivityIndicator(view: self.view, widthView: nil, backgroundColor: UIColor.clear, textColor: UIColor.clear, message: "")

    }
}

