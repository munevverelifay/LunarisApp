//
//  FavoriteViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 28.05.2023.
//

import UIKit
import Alamofire

class FavoriteViewController: UIViewController {
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
        favoritesCollectionView.register(UINib(nibName: String(describing: FavoriteCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FavoriteCell.self))
        favoritesCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        print(GlobalDataManager.sharedGlobalManager.favoriteProductsList)
        
        title = "Favorites"
       
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 249/255, green: 36/255, blue: 87/255, alpha: 1.0)]
    }
    override func viewWillAppear(_ animated: Bool) {
        configureFavoriteData()
    }
    func configureFavoriteData() {
        GlobalDataManager.sharedGlobalManager.favoriteProductsList = []
        NetworkService.sharedNetwork.getFavoriteList(userId: GlobalDataManager.sharedGlobalManager.userId) { response in
            switch response {
            case .success(let value):
                print(value)
                value.forEach { item in
                    GlobalDataManager.sharedGlobalManager.favoriteProductsList.append(contentsOf: item.fav)
                    self.favoritesCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

    
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalDataManager.sharedGlobalManager.favoriteProductsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let favoriteCell = favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoriteCell.self), for: indexPath) as? FavoriteCell else {
            return UICollectionViewCell()
        }
        
        if let favoriteProductId = Int(GlobalDataManager.sharedGlobalManager.favoriteProductsList[indexPath.item]) {
            favoriteCell.favoriteProductNameLabel.text = GlobalDataManager.sharedGlobalManager.productListName?[favoriteProductId]
            favoriteCell.favoriteProductCommentLabel.text = GlobalDataManager.sharedGlobalManager.productListReviewNumbers?[favoriteProductId]
            
            if let imageUrlString = GlobalDataManager.sharedGlobalManager.productListImage?[favoriteProductId],
               let imageUrl = URL(string: imageUrlString) {
                favoriteCell.favoriteProductImageView.kf.setImage(with: imageUrl)
            } else {
                let defaultImageUrlString = "default"
                let defaultImageUrl = URL(string: defaultImageUrlString)
                favoriteCell.favoriteProductImageView.kf.setImage(with: defaultImageUrl)
            }
            
            if let productListTotalRating = GlobalDataManager.sharedGlobalManager.productListTotalRating?[favoriteProductId] {
                productRatingStar(firstStarImage: favoriteCell.firstStarImage, secondStarImage: favoriteCell.secondStarImage, thirdStarImage: favoriteCell.thirdStarImage, fourthStarImage: favoriteCell.fourthStarImage, fifthStarImage: favoriteCell.fifthStarImage, productListTotalRating: productListTotalRating)
            }
        }
        
        return favoriteCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let productDetailVC = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            navigationController?.pushViewController(productDetailVC, animated: true)
            //Index +1 fazla gösteriyordu o yüzden yaptım
            print(indexPath.item)
            if let favoriteProductId = Int(GlobalDataManager.sharedGlobalManager.favoriteProductsList[indexPath.item]) {
                productDetailVC.selectedProductId = GlobalDataManager.sharedGlobalManager.productListId?[favoriteProductId] ?? ""

                GlobalDataManager.sharedGlobalManager.selectedProductId = GlobalDataManager.sharedGlobalManager.productListId?[favoriteProductId] ?? ""
            }
        }
    }
    
    func productRatingStar(firstStarImage: UIImageView, secondStarImage: UIImageView, thirdStarImage: UIImageView, fourthStarImage: UIImageView, fifthStarImage: UIImageView, productListTotalRating: String) {
        if Double(productListTotalRating) ?? 0.0 == 0.0 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        }
        else if Double(productListTotalRating) ?? 0 <= 0.75 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        }else if Double(productListTotalRating) ?? 0 <= 1.25 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        } else if Double(productListTotalRating) ?? 0 <= 1.75 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        } else if Double(productListTotalRating) ?? 0 <= 2.25 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.fill")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        } else if Double(productListTotalRating) ?? 0 <= 2.75 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.fill")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        } else if Double(productListTotalRating) ?? 0 <= 3.25 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.fill")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star.fill")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        } else if Double(productListTotalRating) ?? 0 <= 3.75 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.fill")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star.fill")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        } else if Double(productListTotalRating) ?? 0 <= 4.25 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.fill")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star.fill")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star.fill")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        } else if Double(productListTotalRating) ?? 0 <= 4.75 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.fill")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star.fill")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star.fill")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
        } else if Double(productListTotalRating) ?? 0 <= 5 {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star.fill")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star.fill")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star.fill")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star.fill")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star.fill")
        } else {
            firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            firstStarImage.image = UIImage(systemName: "star")
            secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            secondStarImage.image = UIImage(systemName: "star")
            thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            thirdStarImage.image = UIImage(systemName: "star")
            fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fourthStarImage.image = UIImage(systemName: "star")
            fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            fifthStarImage.image = UIImage(systemName: "star")
        }
    }
    
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 394, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
