//
//  LogoutViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 25/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class ChnageDittoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

          self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yes(_ sender: Any) {
        
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "dittoui") as! DittoViewController
            self.present(balanceViewController, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func no(_ sender: Any) {
        
        self.view.removeFromSuperview()
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
