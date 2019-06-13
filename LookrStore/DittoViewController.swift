//
//  DittoViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 13/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class DittoViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //self.topImageView.image = UIImage.gif(name: "jeremy")
        
        let url = URL (string: "https://www.lookr.in/mobileapp/dittocreation?mobile=8003777766&apptype=mobile&env=prod")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        self.view.addSubview(webView)
        

    }
    
}
