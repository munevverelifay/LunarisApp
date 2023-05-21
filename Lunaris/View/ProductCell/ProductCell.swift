//
//  ProductCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.04.2023.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        productImage.layer.cornerRadius = 10
        productImage.layer.masksToBounds = true
        productBackgroundView.layer.cornerRadius = 22
        layer.applySketchShadow(color: UIColor.black, alpha: 0.04, x: 2, y: 2, blur: 10, spread: 0)
    }

}



