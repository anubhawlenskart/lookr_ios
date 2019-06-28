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
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.backgroundColor = UIColor.white.cgColor
        image.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        image.clipsToBounds = true

    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.image.image = nil
            }
        }
    }
    

}
