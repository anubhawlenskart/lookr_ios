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
        
        let url = URL (string: "https://labs.lenskart.com/v108/lookr/mobileapp/dittocreation?mobile="+mnumber+"&apptype=store&env=prod")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        self.view.addSubview(webView)
        
        webView.delegate = self


    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if request.url?.absoluteString == "https://labs.lenskart.com/v108/lookr/" {
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "wishlistui") as! WishlistViewController
               // self.present(balanceViewController, animated: true, completion: nil)
                 self.navigationController?.pushViewController(balanceViewController, animated: true)
            }
            return false
        }
        return true
    }
    
}
