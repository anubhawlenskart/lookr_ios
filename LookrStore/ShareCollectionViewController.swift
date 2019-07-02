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
    @IBOutlet weak var editnumber: MyButton!
    
    var dittoid = "" ,token = "" , mnumber = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        editnumber.becomeFirstResponder()
        

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
        
        editnumber.text = mnumber
        editnumber.removeBorder(false)
        
    }
    
    @objc func tappedMeback(){
        dismiss(animated: true, completion: nil)
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
    
    
    @IBAction func editButton(_ sender: Any) {
        
        editnumber.isUserInteractionEnabled=true
        editnumber.removeBorder(true)
        
        
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
        var encodedurl =  "\(LookrConstants.sharedInstance.baseURL)mobileapp/comparison?mobile=\(mnumber)&filtertype=all&apptype=store"
        
        
        if let intnumebr = Int(editnumber.text!){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)sendcomraisonsms?mobile=\(intnumebr)&comparisonurl=\(encodedurl)"
            
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
                    self.dismiss(animated: true, completion: nil)
                    
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count >= 10 {
            return false
        }
        return true
    }
    
}
