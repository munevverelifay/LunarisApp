//
//  FavoriteCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 28.05.2023.
//

import UIKit

class FavoriteCell: UICollectionViewCell {

    @IBOutlet weak var favoriteCellView: UIView!
    @IBOutlet weak var favoriteProductImageView: UIImageView!
    @IBOutlet weak var favoriteProductNameLabel: UILabel!
    @IBOutlet weak var favoriteProductCommentLabel: UILabel!
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteCellView.layer.cornerRadius = 20
        favoriteCellView.layer.cornerRadius = 20
 
        favoriteProductImageView.layer.cornerRadius = favoriteProductImageView.frame.height / 2
        
        layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
    }

}
