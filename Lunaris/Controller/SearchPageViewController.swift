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
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var allProductsButton: UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    let productId = "1"
//    var pickerView: UIPickerView!
    var pickerViewData: Set<String> = []
    var isPickerViewShown: Bool = false
    var categoriesSet = Set<String>()
    
    var filteredProducts: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton(btn: allProductsButton)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(UINib(nibName: String(describing: ProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductCell.self))
        title = "Search"
        productCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        configureNavigationTitle()
        configureView(bgView: categoryView)
        
        // PickerView'i oluşturun
//        pickerView = UIPickerView()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.isHidden = true
        //        view.addSubview(pickerView)
        
        configureCategory()

        // PickerView'i categoryLabel'a bağlayın
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPickerView))
        categoryLabel.isUserInteractionEnabled = true
        categoryLabel.addGestureRecognizer(tapGesture)

        // GlobalDataManager.sharedGlobalManager.productListCategories verilerini pickerViewData'ya ata
        if let categories = GlobalDataManager.sharedGlobalManager.productListCategories {
            pickerViewData = Set(categories)
        }
        
//        if let categories = GlobalDataManager.sharedGlobalManager.productListCategories {
//
//            let uniqueCategories = Array(Set(categories))
//            let categoryCounts = categories.reduce(into: [:]) { counts, category in
//                counts[category, default: 0] += 1
//            }
//
//            print("Benzersiz kategori sayısı: \(uniqueCategories.count)")
//            for category in uniqueCategories {
//                let count = categoryCounts[category] ?? 0
//                print("\(category): \(count) adet")
//            }
//        }

    }
    func configureCategory() {
        if let categories = GlobalDataManager.sharedGlobalManager.productListCategories {
            categoriesSet = Set(categories)
            var controlCategori = 0
            var indexProductListCategories = 0
            var appendIndex : [Int] = []
            categoriesSet.forEach { categori in
                GlobalDataManager.sharedGlobalManager.productListCategories?.forEach({ item in
                    if item ==  categori {
                        appendIndex.append(indexProductListCategories)
                    }
                    indexProductListCategories += 1
                })
                GlobalDataManager.sharedGlobalManager.receiverCategories.append(appendIndex)
                controlCategori += 1
                indexProductListCategories = 0
                appendIndex = []
            }
        }
    }
    
    @IBAction func allProductsButtonPressed(_ sender: UIButton) {
        categoryLabel.text = "Category" // Kategori seçimini temizle
        GlobalDataManager.sharedGlobalManager.selectedCategory = "" // Seçilen kategoriyi temizle
        categoryPickerView.selectRow(0, inComponent: 0, animated: true) // PickerView'daki seçimi temizle
        
        // Diğer işlemleri yapabilirsiniz (örneğin, filtrelemeyi kaldırabilirsiniz)
        
        productCollectionView.reloadData() // CollectionView'i güncelle
    }

    
    @objc func showPickerView() {
        categoryPickerView.isHidden = false
        isPickerViewShown = true
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
        if GlobalDataManager.sharedGlobalManager.selectedCategory == categoryLabel.text  {
            return GlobalDataManager.sharedGlobalManager.receiverName.count
        } else {
            return GlobalDataManager.sharedGlobalManager.productListId?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let productCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        if GlobalDataManager.sharedGlobalManager.selectedCategory == categoryLabel.text {
            productCell.productNameLabel.text = GlobalDataManager.sharedGlobalManager.receiverName[indexPath.item]
            productCell.productCategoryLabel.text = GlobalDataManager.sharedGlobalManager.receiverProductCategory[indexPath.item]
            productCell.productBrandLabel.text = GlobalDataManager.sharedGlobalManager.receiverBrand[indexPath.item]
            //        productCell.productTotalRatin.text = GlobalDataManager.sharedGlobalManager.productListTotalRating?[indexPath.item]
            let imageUrlString = GlobalDataManager.sharedGlobalManager.receiverImage[indexPath.item]
            if let imageUrl = URL(string: imageUrlString) {
                productCell.productImage.kf.setImage(with: imageUrl)
            } else {
                let defaultImageUrlString = "cerave"
                let defaultImageUrl = URL(string: defaultImageUrlString)
                productCell.productImage.kf.setImage(with: defaultImageUrl)
            }
            
            return productCell
        } else {
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
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let productDetailVC = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            navigationController?.pushViewController(productDetailVC, animated: true)
            //Index +1 fazla gösteriyordu o yüzden yaptım
            if GlobalDataManager.sharedGlobalManager.selectedCategory == categoryLabel.text  {
                print(indexPath.item)
                productDetailVC.selectedProductId = GlobalDataManager.sharedGlobalManager.receiverId[indexPath.item]
                
                GlobalDataManager.sharedGlobalManager.selectedProductId = GlobalDataManager.sharedGlobalManager.receiverId[indexPath.item]
            } else {
                print(indexPath.item)
                productDetailVC.selectedProductId = GlobalDataManager.sharedGlobalManager.productListId?[indexPath.item] ?? ""
                
                GlobalDataManager.sharedGlobalManager.selectedProductId = GlobalDataManager.sharedGlobalManager.productListId?[indexPath.item] ?? ""
            }
          
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

extension SearchPageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(pickerViewData)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Seçilen kategoriyi categoryLabel'a ata
        let selectedCategory = Array(pickerViewData)[row]
        GlobalDataManager.sharedGlobalManager.receiverId = []
        GlobalDataManager.sharedGlobalManager.receiverName = []
        GlobalDataManager.sharedGlobalManager.receiverProductCategory = []
        GlobalDataManager.sharedGlobalManager.receiverBrand = []
        GlobalDataManager.sharedGlobalManager.receiverIngredients = []
        GlobalDataManager.sharedGlobalManager.receiverImage = []
        GlobalDataManager.sharedGlobalManager.receiverTotalRating = []
        GlobalDataManager.sharedGlobalManager.receiverReviewNumbers = []
        categoryLabel.text = selectedCategory
        
        // Seçilen değeri başka bir değişkende saklamak için aşağıdaki satırı ekleyebilirsiniz
        GlobalDataManager.sharedGlobalManager.selectedCategory = selectedCategory
        
        for (index, item) in categoriesSet.enumerated() {
            if item == GlobalDataManager.sharedGlobalManager.selectedCategory {
                for outerArray in GlobalDataManager.sharedGlobalManager.receiverCategories {
                    if let recieverIndex = GlobalDataManager.sharedGlobalManager.receiverCategories.firstIndex(of: outerArray) {
                        if recieverIndex == index {
                            // İç içe array'e girmek için burada işlemler yapabilirsiniz
                            print("İç içe array bulundu! İndeks: \(recieverIndex)")
                            // outerArray içindeki elemanlara erişebilirsiniz
                            for item in outerArray {
                                print("Eleman: \(item)")
                                GlobalDataManager.sharedGlobalManager.receiverId.append(GlobalDataManager.sharedGlobalManager.productListId?[item] ?? "")
                                GlobalDataManager.sharedGlobalManager.receiverName.append(GlobalDataManager.sharedGlobalManager.productListName?[item] ?? "")
                                GlobalDataManager.sharedGlobalManager.receiverProductCategory.append(GlobalDataManager.sharedGlobalManager.productListCategories?[item] ?? "")
                                GlobalDataManager.sharedGlobalManager.receiverBrand.append(GlobalDataManager.sharedGlobalManager.productListBrand?[item] ?? "")
                                GlobalDataManager.sharedGlobalManager.receiverImage.append(GlobalDataManager.sharedGlobalManager.productListImage?[item] ?? "")
                              
                            }
                        }
                    }
                }

            }
        }
        
        // PickerView'i gizle
        categoryPickerView.isHidden = true
        isPickerViewShown = false
        productCollectionView.reloadData()
    }
}

