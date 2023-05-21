//
//  ProfileProductCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 9.04.2023.
//

import UIKit

class ProfileProductCell: UICollectionViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productBrandNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        productImage.layer.cornerRadius = 10
        productImage.layer.masksToBounds = true
        productBackgroundView.layer.cornerRadius = 22
        layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
    }
//    func applyShadowOnView(_ view: UIView) {
//        view.layer.shadowRadius = 5
//        view.layer.shadowOffset = .zero
//        view.layer.shadowOpacity = 0.1
//        view.layer.shadowColor =   UIColor(red: 90/255, green: 108/255, blue: 234/255, alpha: 1).cgColor
//        view.layer.masksToBounds = false
//        view.layer.shadowOffset = CGSize(width: 2, height: 1)
//    }


}
