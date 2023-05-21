//
//  ShelfPageViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.04.2023.
//

import UIKit
import Alamofire

class ShelfPageViewController: UIViewController {
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var notFinishedView: UIView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    let productId = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(bgView: categoryView)
        configureView(bgView: brandView)
        configureView(bgView: notFinishedView)
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(UINib(nibName: String(describing: ProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductCell.self))
        productCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        

//        configureData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
//    func configureData() {
//        NetworkService.sharedNetwork.getProductDetail(product_id: "1") { response in
//            switch response{
//            case .success(let value):
//                print(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}

extension ShelfPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let productCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        //        productCell.layer.cornerRadius = 30
        //        productCell.layer.masksToBounds = true
        
        return productCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 3 { // 3. hücre seçildiğinde
            if let productDetailVC = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
                navigationController?.pushViewController(productDetailVC, animated: true)
            }
        }
    }
}

extension ShelfPageViewController: UICollectionViewDelegateFlowLayout {
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
