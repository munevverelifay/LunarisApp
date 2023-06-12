//
//  ReviewsCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.05.2023.
//

import UIKit

class ReviewsCell: UITableViewCell {
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var reviewView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
