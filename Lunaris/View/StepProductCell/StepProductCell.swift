//
//  StepProductCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 19.05.2023.
//

import UIKit

class StepProductCell: UICollectionViewCell {
    @IBOutlet weak var stepProductView: UIView!
    @IBOutlet weak var stepProductImageView: UIImageView!
    @IBOutlet weak var stepProductBrandNameLabel: UILabel!
    
    @IBOutlet weak var stepProductNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stepProductView.layer.cornerRadius = 20
        stepProductView.layer.cornerRadius = 20
 
        stepProductImageView.layer.cornerRadius = stepProductImageView.frame.height / 2
        
        layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
        
    }
    
    
}
