//
//  ViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 06/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var txtMobileNo: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
        
        //self.topImageView.image = UIImage.gif(name: "jeremy")
        let url = URL(string: "https://labs.lenskart.com/v108/lookr/api/")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // URLSession.shared().dataTask(with: url) { (data, response, error) is now URLSession.shared.dataTask(with: url) { (data, response, error)
            
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

