//
//  StepProductViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 19.05.2023.
//


import UIKit

class StepProductViewController: UIViewController {
    
    @IBOutlet weak var stepProductCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepProductCollectionView.dataSource = self
        stepProductCollectionView.delegate = self
        stepProductCollectionView.register(UINib(nibName: String(describing: StepProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: StepProductCell.self))
        stepProductCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
}

extension StepProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let stepProductCell = stepProductCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StepProductCell.self), for: indexPath) as? StepProductCell else {
            return UICollectionViewCell()
        }

        return stepProductCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension StepProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}


