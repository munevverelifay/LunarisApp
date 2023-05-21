//
//  SelectStepViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 11.05.2023.
//

import UIKit

class SelectStepViewController: UIViewController {
    
    @IBOutlet weak var selectStepCollectionView: UICollectionView!
    
    //Categories
    var productCategoriesArray: [String]? = ["Cleanser",
                                             "Toner",
                                             "Exfoliant",
                                             "Treatment",
                                             "Hydrator",
                                             "Moisturizer",
                                             "Serum",
                                             "Sun protection",
                                             "Makeup Remover",
                                             "Eye care",
                                             "Mask",
                                             "Oil",
                                             "Lips Care",
                                             "Tool"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectStepCollectionView.dataSource = self
        selectStepCollectionView.delegate = self
        selectStepCollectionView.register(UINib(nibName: String(describing: SelectStepCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SelectStepCell.self))
        selectStepCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
}

extension SelectStepViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCategoriesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let selectStepCell = selectStepCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SelectStepCell.self), for: indexPath) as? SelectStepCell else {
            return UICollectionViewCell()
        }
        
        selectStepCell.stepNameLabel.text = productCategoriesArray?[indexPath.item]
        
        return selectStepCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension SelectStepViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 384, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

