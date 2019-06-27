//
//  CollectionimageViewController.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 24/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class CollectionimageViewController: UICollectionViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var framsimage: UIImageView!
    
    @IBOutlet weak var brandname: UILabel!
    @IBOutlet weak var sku: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageview.layer.cornerRadius = 10
        imageview.clipsToBounds = true
        imageview.layer.borderWidth = 3
        imageview.layer.borderColor = UIColor.white.cgColor
    
        
        framsimage.layer.borderWidth = 1.0
        framsimage.layer.masksToBounds = false
        framsimage.layer.borderColor = UIColor.white.cgColor
        framsimage.layer.cornerRadius = framsimage.frame.height/2
        framsimage.clipsToBounds = true
        
        
    }
    

    @IBAction func deleteButton(_ sender: Any) {
        
        
    }
    
    
    @IBAction func info(_ sender: Any) {
        brandname.isHidden = !brandname.isHidden
        sku.isHidden = !sku.isHidden

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
