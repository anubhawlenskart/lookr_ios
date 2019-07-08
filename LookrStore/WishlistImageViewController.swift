//
//  WishlistImageViewCell.swift
//  LookrStore
//
//  Created by Keshav Gangwal on 20/06/19.
//  Copyright © 2019 Lenskart. All rights reserved.
//

import UIKit

class WishlistImageViewCell: UICollectionViewCell {
        
    @IBOutlet weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.roundedImage()

        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
               // self.image.image = nil
            }
        }
    }
    
    
}




extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}
