//
//  RoutineStepCell.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 9.05.2023.
//

import UIKit

class RoutineStepCell: UICollectionViewCell {
    @IBOutlet weak var stepView: UIView!
    @IBOutlet weak var stepNumberLabel: UILabel!
    @IBOutlet weak var stepNameLabel: UILabel!
    @IBOutlet weak var editStepNameImage: UIImageView!
    @IBOutlet weak var addStepProductImageView: UIImageView!
    @IBOutlet weak var stepProductView: UIView!
    @IBOutlet weak var stepProductImage: UIImageView!
    @IBOutlet weak var stepProductBrandLabel: UILabel!
    @IBOutlet weak var stepProductNameLabel: UILabel!
    @IBOutlet weak var stepDaysView: UIView!
    @IBOutlet weak var deleteStepButton: UIButton!
    @IBOutlet weak var deleteStepImage: UIImageView!
    @IBOutlet weak var monView: UIView!
    @IBOutlet weak var tueView: UIView!
    @IBOutlet weak var wedView: UIView!
    @IBOutlet weak var thuView: UIView!
    @IBOutlet weak var friView: UIView!
    @IBOutlet weak var satView: UIView!
    @IBOutlet weak var sunView: UIView!
    
    @IBOutlet weak var monLabel: UILabel!
    @IBOutlet weak var tueLabel: UILabel!
    @IBOutlet weak var wedLabel: UILabel!
    @IBOutlet weak var thuLabel: UILabel!
    @IBOutlet weak var friLabel: UILabel!
    @IBOutlet weak var satLabel: UILabel!
    @IBOutlet weak var sunLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stepView.layer.cornerRadius = 20
        stepProductView.layer.cornerRadius = 20
        stepDaysView.layer.cornerRadius = 20
        
        stepProductImage.layer.cornerRadius = stepProductImage.frame.height / 2
        
        configureView(view: monView)
        configureView(view: tueView)
        configureView(view: wedView)
        configureView(view: thuView)
        configureView(view: friView)
        configureView(view: satView)
        configureView(view: sunView)
        
        layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
   
    }
    
    func configureView(view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
    }
}
