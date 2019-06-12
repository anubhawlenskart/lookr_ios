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
        btnLogin.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
        
        //self.topImageView.image = UIImage.gif(name: "jeremy")

    }

    @IBAction func btnLoginDidClick(_ sender: Any) {
        performSegue(withIdentifier: "HomeViewController", sender: self)

    }
    
    

}

