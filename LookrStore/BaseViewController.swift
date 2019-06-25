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

