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
    var filteredProductsName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepProductCollectionView.dataSource = self
        stepProductCollectionView.delegate = self
        stepProductCollectionView.register(UINib(nibName: String(describing: StepProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: StepProductCell.self))
        stepProductCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
    func filterProducts(with searchText: String) {
        if searchText.isEmpty {
            // Arama metni boş ise, filtrelenmiş ürünleri temizleyin
            
            filteredProductsName = []
            stepProductCollectionView.reloadData()
        } else {
            // Arama metni boş değilse, productList'teki ürünleri filtreleyin
            filteredProductsName = GlobalDataManager.sharedGlobalManager.productListName?.filter { product in
                // Arama metnini ürün adı veya kategori ile karşılaştırın
                let productName = product.lowercased()
                let lowercasedSearchText = searchText.lowercased()
                return productName.contains(lowercasedSearchText)
            } ?? []

            // Filtrelenmiş ürünlerin indekslerini kaydetmek için döngüyü kullanın
            var filteredProductsIds: [Int] = []
            GlobalDataManager.sharedGlobalManager.searchId = []
            GlobalDataManager.sharedGlobalManager.searchProductCategory = []
            GlobalDataManager.sharedGlobalManager.searchBrand = []
            GlobalDataManager.sharedGlobalManager.searchImage = []
            var filteredIndexes: [Int] = []
            for filteredProduct in filteredProductsName {
                if let index = GlobalDataManager.sharedGlobalManager.productListName?.firstIndex(of: filteredProduct) {
                    filteredIndexes.append(index)
                }
            }

            // filteredIndexes dizisini kullanarak diğer işlemleri yapabilirsiniz
            // Örneğin, GlobalDataManager.sharedGlobalManager.productListId içinden ilgili ürün ID'lerini alabilirsiniz
            filteredProductsIds = filteredIndexes.compactMap { index in
                guard let id = GlobalDataManager.sharedGlobalManager.productListId?[index] else {
                    return nil
                }
                return Int(id)
            }
            print(filteredProductsIds)
            filteredProductsIds.forEach { item in
                GlobalDataManager.sharedGlobalManager.searchId.append(GlobalDataManager.sharedGlobalManager.productListId?[item] ?? "")
                GlobalDataManager.sharedGlobalManager.searchProductCategory.append(GlobalDataManager.sharedGlobalManager.productListCategories?[item] ?? "")
                GlobalDataManager.sharedGlobalManager.searchBrand.append(GlobalDataManager.sharedGlobalManager.productListBrand?[item] ?? "")
                GlobalDataManager.sharedGlobalManager.searchImage.append(GlobalDataManager.sharedGlobalManager.productListImage?[item] ?? "")
            }
            stepProductCollectionView.reloadData()
        }
    }
    
}
extension StepProductViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Arama metni her değiştiğinde filtrelemeyi uygula

        filterProducts(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Klavyede "Ara" düğmesine basıldığında klavyeyi gizle
        searchBar.resignFirstResponder()
    }
}

extension StepProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !filteredProductsName.isEmpty {
            return filteredProductsName.count
        } else {
            return GlobalDataManager.sharedGlobalManager.productListId?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let stepProductCell = stepProductCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StepProductCell.self), for: indexPath) as? StepProductCell else {
            return UICollectionViewCell()
        }
        
        if !filteredProductsName.isEmpty {
            
            stepProductCell.stepProductNameLabel.text = filteredProductsName[indexPath.item]
            stepProductCell.stepProductBrandNameLabel.text = GlobalDataManager.sharedGlobalManager.searchBrand[indexPath.item]
            let imageUrlString = GlobalDataManager.sharedGlobalManager.searchImage[indexPath.item]
            if let imageUrl = URL(string: imageUrlString) {
                stepProductCell.stepProductImageView.kf.setImage(with: imageUrl)
            } else {
                let defaultImageUrlString = "skincare"
                let defaultImageUrl = URL(string: defaultImageUrlString)
                stepProductCell.stepProductImageView.kf.setImage(with: defaultImageUrl)
            }
            
            return stepProductCell
        } else {
            stepProductCell.stepProductNameLabel.text = GlobalDataManager.sharedGlobalManager.productListName?[indexPath.item]
            stepProductCell.stepProductBrandNameLabel.text = GlobalDataManager.sharedGlobalManager.productListBrand?[indexPath.item]
    //        productCell.productTotalRatin.text = GlobalDataManager.sharedGlobalManager.productListTotalRating?[indexPath.item]
            if let imageUrlString = GlobalDataManager.sharedGlobalManager.productListImage?[indexPath.item],
               let imageUrl = URL(string: imageUrlString) {
                stepProductCell.stepProductImageView.kf.setImage(with: imageUrl)
            } else {
                let defaultImageUrlString = "skincare"
                let defaultImageUrl = URL(string: defaultImageUrlString)
                stepProductCell.stepProductImageView.kf.setImage(with: defaultImageUrl)
            }

            return stepProductCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !filteredProductsName.isEmpty {
            let selectedProductName = filteredProductsName[indexPath.item]
            let selectedProductBrand = GlobalDataManager.sharedGlobalManager.searchBrand[indexPath.item]
            let selectedProductId = GlobalDataManager.sharedGlobalManager.searchId[indexPath.item]
            let selectedProductImage = GlobalDataManager.sharedGlobalManager.searchImage[indexPath.item]
            // Diğer değerleri de burada alabilirsiniz
            let selectedProductIndex = selectProduct
            
            let userInfo: [String: Any] = [
                "productName": selectedProductName ,
                "productBrand": selectedProductBrand ,
                "productIndex": selectedProductIndex,
                "productId": selectedProductId ,
                "productImage": selectedProductImage 
            ]
            
            NotificationCenter.default.post(name: Notification.Name("SelectedProduct"), object: nil, userInfo: userInfo)
            navigationController?.popViewController(animated: true)

        } else {
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


