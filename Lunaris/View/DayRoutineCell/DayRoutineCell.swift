//
//  DayRoutineCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 4.06.2023.
//

import UIKit

class DayRoutineCell: UITableViewCell {
    
    @IBOutlet weak var dayRoutineView: UIView!
    @IBOutlet weak var dayProductRoutineView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dayRoutineView.layer.cornerRadius = 20
        dayProductRoutineView.layer.cornerRadius = 20
        productImageView.layer.cornerRadius = productImageView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
