//
//  searchPageViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.04.2023.
//

import UIKit
import Kingfisher

class SearchPageViewController: UIViewController {
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    let productId = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(UINib(nibName: String(describing: ProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductCell.self))
        title = "Search"
        productCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        configureNavigationTitle()
        configureView(bgView: categoryView)

    }

}
extension UIViewController {
    func configureView(bgView: UIView) {
        bgView.layer.cornerRadius = bgView.frame.height / 2.5
    }
    
    func configureRoutinesLabelView(routineBgView: UIView, routineBgColor: UIColor) {
        routineBgView.layer.cornerRadius = routineBgView.frame.height / 2
        routineBgView.backgroundColor = routineBgColor
        routineBgView.layer.borderColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0).cgColor
        routineBgView.layer.borderWidth = 2.0

    }
}

extension SearchPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalDataManager.sharedGlobalManager.productListId?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let productCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        productCell.productNameLabel.text = GlobalDataManager.sharedGlobalManager.productListName?[indexPath.item]
        productCell.productCategoryLabel.text = GlobalDataManager.sharedGlobalManager.productListCategories?[indexPath.item]
        productCell.productBrandLabel.text = GlobalDataManager.sharedGlobalManager.productListBrand?[indexPath.item]
//        productCell.productTotalRatin.text = GlobalDataManager.sharedGlobalManager.productListTotalRating?[indexPath.item]
        if let imageUrlString = GlobalDataManager.sharedGlobalManager.productListImage?[indexPath.item],
           let imageUrl = URL(string: imageUrlString) {
            productCell.productImage.kf.setImage(with: imageUrl)
        } else {
            let defaultImageUrlString = "cerave"
            let defaultImageUrl = URL(string: defaultImageUrlString)
            productCell.productImage.kf.setImage(with: defaultImageUrl)
        }

        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let productDetailVC = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            navigationController?.pushViewController(productDetailVC, animated: true)
            //Index +1 fazla gösteriyordu o yüzden yaptım
            print(indexPath.item)
            productDetailVC.selectedProductId = GlobalDataManager.sharedGlobalManager.productListId?[indexPath.item] ?? ""

            GlobalDataManager.sharedGlobalManager.selectedProductId = GlobalDataManager.sharedGlobalManager.productListId?[indexPath.item] ?? ""
        }
        
    }
}

extension SearchPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
}
