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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        framsimage.layer.borderWidth = 1
        framsimage.layer.masksToBounds = false
        framsimage.layer.borderColor = UIColor.white.cgColor
        framsimage.layer.backgroundColor = UIColor.white.cgColor

    
        
        
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
