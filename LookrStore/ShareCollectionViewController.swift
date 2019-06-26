//
//  ShareCollectionViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 20/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class ShareCollectionViewController: UIViewController {
    @IBOutlet weak var close: UIImageView!
    
    var dittoid = "" ,token = "" , mnumber = ""

    
    @IBOutlet weak var editnumber: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let tapclose = UITapGestureRecognizer(target: self, action: #selector(CollectionViewController.tappedMeback))
        
        close.addGestureRecognizer(tapclose)
        close.isUserInteractionEnabled = true
        
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: "dittoid") {
            dittoid = stringOne
        }
        if let stringTwo = defaults.string(forKey: "token") {
            token = stringTwo
        }
        
        if let stringThree = defaults.string(forKey: "mobileno") {
            mnumber = stringThree
        }
        
    
    }
    
    @objc func tappedMeback(){
        self.view.removeFromSuperview()

    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }


    @IBAction func sendbutton(_ sender: Any) {
        
        if editnumber.text == "" {
            
            let alert = UIAlertController(title: "Error", message: "Enter Mobile Number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style : .default , handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
           // self.present(alert, animated: true, completion: nil)
            
        }else {
            
            gotosharewishilistAPI()
        }
        
        
    }
    
    
    func gotosharewishilistAPI(){
        var encodedurl =  "\(LookrConstants.sharedInstance.baseSMS)mobileapp/comparison?mobile=\(mnumber)&dittoid=\(self.dittoid)&filtertype=all&apptype=store" ;

        
        if let intnumebr = Int(editnumber.text!){
            let urlstring = "\(LookrConstants.sharedInstance.baseSMS)sendcomraisonsms?mobile=\(intnumebr)&comparisonurl=\(encodedurl)"
            
            let params = ["":""] as Dictionary<String, String>
            var request = URLRequest(url: URL(string: urlstring)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    let posts = json["success"] as? [[String: Any]] ?? []
                    
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
}
