//
//  DittoViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 13/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class DittoViewController: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    
    var dittoid = "" ,token = "" , mnumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: "dittoid") {
            print(stringOne) // Some String Value
            dittoid = stringOne
        }
        if let stringTwo = defaults.string(forKey: "token") {
            print(stringTwo) // Another String Value
            token = stringTwo
        }
        
        if let stringThree = defaults.string(forKey: "mobileno") {
            print(stringThree) // Another String Value
            mnumber = stringThree
        }
        
        let url = URL (string: "\(LookrConstants.sharedInstance.baseURL)mobileapp/dittocreation?mobile="+mnumber+"&apptype=store&env=prod")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        self.view.addSubview(webView)
        
        webView.delegate = self


    }
    
    
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if request.url?.absoluteString == "https://labs.lenskart.com/v108/lookr/" {
            
            self.gotodittoAPI()
            
            return false
        }
        return true
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
   
        self.dismiss(animated: true, completion: nil)

    }
    
    
    func gotodittoAPI(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)getuserditto?mobile=\(intnumebr)"
            
            let params = ["":""] as Dictionary<String, String>
            var request = URLRequest(url: URL(string: urlstring)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        
                        let data = json["success"] as? [String: Any]
                        let dittoid = data?["dittoid"] as? [String: AnyObject]
                        let defaults = UserDefaults.standard
                        defaults.set(dittoid , forKey: "dittoid")
                       
                        DispatchQueue.main.async {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "wishlistui") as! UserFreameViewController
                            // self.present(balanceViewController, animated: true, completion: nil)
                            self.navigationController?.pushViewController(balanceViewController, animated: true)
                        }
                      
                        
                    }catch {
                        print("error")
                    }
                }
            })
            
            task.resume()
            
        }
        
    }
    
    
    
    func gotosetDittoAPI(){
        if let intnumebr = Int(mnumber){
            let urlstring = "\(LookrConstants.sharedInstance.baseURL)setditto?mobile=\(intnumebr)$dittoid="
            
            let params = ["":""] as Dictionary<String, String>
            var request = URLRequest(url: URL(string: urlstring)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        
                        let data = json["success"] as? [String: Any]
                        let dittoid = data?["dittoid"] as? [String: AnyObject]
                        let defaults = UserDefaults.standard
                        defaults.set(dittoid , forKey: "dittoid")
                        
                        DispatchQueue.main.async {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "wishlistui") as! UserFreameViewController
                            // self.present(balanceViewController, animated: true, completion: nil)
                            self.navigationController?.pushViewController(balanceViewController, animated: true)
                        }
                        
                        
                    }catch {
                        print("error")
                    }
                }
            })
            
            task.resume()
            
        }
        
    }
    
    
}
