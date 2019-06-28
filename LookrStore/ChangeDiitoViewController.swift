//
//  LogoutViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 25/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class ChnageDittoViewController: UIViewController {

    @IBOutlet weak var textfiled: UILabel!
    
    var dittoid = "" ,token = "" , mnumber = "", filterglassstring="Sunglasses" ,sku = ""

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        textfiled.text = "Is \(mnumber)  Your Number ? "
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yes(_ sender: Any) {
        
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "dittoui") as! DittoViewController
           // self.present(balanceViewController, animated: true, completion: nil)
          self.navigationController?.pushViewController(balanceViewController, animated: true)
        
    }
    
    
    @IBAction func no(_ sender: Any) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
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
    


}
