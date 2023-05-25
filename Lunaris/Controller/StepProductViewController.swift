//
//  StepProductViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 19.05.2023.
//


import UIKit

class StepProductViewController: UIViewController {
    
    @IBOutlet weak var stepProductCollectionView: UICollectionView!
    
    var selectProduct: Int = 0
    
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
        return GlobalDataManager.sharedGlobalManager.productListId?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let stepProductCell = stepProductCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StepProductCell.self), for: indexPath) as? StepProductCell else {
            return UICollectionViewCell()
        }
        
        stepProductCell.stepProductNameLabel.text = GlobalDataManager.sharedGlobalManager.productListName?[indexPath.item]
        stepProductCell.stepProductBrandNameLabel.text = GlobalDataManager.sharedGlobalManager.productListBrand?[indexPath.item]
//        productCell.productTotalRatin.text = GlobalDataManager.sharedGlobalManager.productListTotalRating?[indexPath.item]
        if let imageUrlString = GlobalDataManager.sharedGlobalManager.productListImage?[indexPath.item],
           let imageUrl = URL(string: imageUrlString) {
            stepProductCell.stepProductImageView.kf.setImage(with: imageUrl)
        } else {
            let defaultImageUrlString = "cerave"
            let defaultImageUrl = URL(string: defaultImageUrlString)
            stepProductCell.stepProductImageView.kf.setImage(with: defaultImageUrl)
        }

        return stepProductCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProductName = GlobalDataManager.sharedGlobalManager.productListName?[indexPath.item]
        let selectedProductBrand = GlobalDataManager.sharedGlobalManager.productListBrand?[indexPath.item]
        let selectedProductId = GlobalDataManager.sharedGlobalManager.productListId?[indexPath.item]
        let selectedProductImage = GlobalDataManager.sharedGlobalManager.productListImage?[indexPath.item]
        // Diğer değerleri de burada alabilirsiniz
        let selectedProductIndex = selectProduct
        
        let userInfo: [String: Any] = [
            "productName": selectedProductName ?? "",
            "productBrand": selectedProductBrand ?? "",
            "productIndex": selectedProductIndex,
            "productId": selectedProductId ?? "",
            "productImage": selectedProductImage ?? ""
        ]
        
        NotificationCenter.default.post(name: Notification.Name("SelectedProduct"), object: nil, userInfo: userInfo)
        navigationController?.popViewController(animated: true)
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


