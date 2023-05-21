//
//  CommentCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.05.2023.
//

import UIKit

class CommentCell: UICollectionViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentDateLabel: UILabel!
    @IBOutlet weak var commentInfoView: UIView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userProfileImage.layer.cornerRadius = 30
        userProfileImage.layer.masksToBounds = true
    
        commentView.layer.cornerRadius = 22
        commentInfoView.layer.cornerRadius = 22
//        applyShadowOnView(commentInfoView)
        
        layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
    }

}
