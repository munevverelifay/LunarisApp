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
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var allProductsButton: UIButton!
    @IBOutlet weak var productSearch: UISearchBar!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var brandPickerView: UIPickerView!
    
    let productId = "1"
//    var pickerView: UIPickerView!
    var pickerViewData: Set<String> = []
    var isPickerViewShown: Bool = false
    var isBrandPickerViewShown: Bool = false
    var categoriesSet = Set<String>()
    
    var brandsSet = Set<String>()
    var brandPickerViewData: Set<String> = []
    
    var filteredProductsName: [String] = []
    
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
        configureView(bgView: brandView)
        
        productSearch.delegate = self
        
        // PickerView'i oluşturun
//        pickerView = UIPickerView()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.isHidden = true
        
        
        configureCategory()

        // PickerView'i categoryLabel'a bağlayın
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPickerView))
        categoryLabel.isUserInteractionEnabled = true
        categoryLabel.addGestureRecognizer(tapGesture)

        // GlobalDataManager.sharedGlobalManager.productListCategories verilerini pickerViewData'ya ata
        if let categories = GlobalDataManager.sharedGlobalManager.productListCategories {
            pickerViewData = Set(categories)
        }
        
        brandPickerView.delegate = self
        brandPickerView.dataSource = self
        brandPickerView.isHidden = true
        configureBrand()
        // PickerView'i brandLabel'a bağlayın
        let brandTapGesture = UITapGestureRecognizer(target: self, action: #selector(showBrandPickerView))
        brandLabel.isUserInteractionEnabled = true
        brandLabel.addGestureRecognizer(brandTapGesture)
        
        // GlobalDataManager.sharedGlobalManager.productListBrand verilerini pickerViewData'ya ata
        if let brands = GlobalDataManager.sharedGlobalManager.productListBrand {
            brandPickerViewData = Set(brands)
        }
        
        
    }
    
    func filterProducts(with searchText: String) {
        if searchText.isEmpty {
            // Arama metni boş ise, filtrelenmiş ürünleri temizleyin
            
            filteredProductsName = []
            productCollectionView.reloadData()
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
            productCollectionView.reloadData()
        }
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
    
    func configureBrand() {
        if let brands = GlobalDataManager.sharedGlobalManager.productListBrand {
            brandsSet = Set(brands)
            var controlBrand = 0
            var indexProductListBrand = 0
            var appendBrandIndex : [Int] = []
            brandsSet.forEach { brand in
                GlobalDataManager.sharedGlobalManager.productListBrand?.forEach({ item in
                    if item ==  brand {
                        appendBrandIndex.append(indexProductListBrand)
                    }
                    indexProductListBrand += 1
                })
                GlobalDataManager.sharedGlobalManager.receiverBrands.append(appendBrandIndex)
                controlBrand += 1
                indexProductListBrand = 0
                appendBrandIndex = []
            }
        }
    }
    
    @IBAction func allProductsButtonPressed(_ sender: UIButton) {
        categoryLabel.text = "Category" // Kategori seçimini temizle
        GlobalDataManager.sharedGlobalManager.selectedCategory = "" // Seçilen kategoriyi temizle
        categoryPickerView.selectRow(0, inComponent: 0, animated: true) // PickerView'daki seçimi temizle
        
        brandLabel.text = "Brand" // Brand seçimini temizle
        GlobalDataManager.sharedGlobalManager.selectedBrand = "" // Seçilen markayı temizle
        brandPickerView.selectRow(0, inComponent: 0, animated: true) // PickerView'daki seçimi temizle

        productCollectionView.reloadData() // CollectionView'i güncelle
    }
    
    @objc func showPickerView() {
        categoryPickerView.isHidden = false
        brandLabel.text = "Brand" // Brand seçimini temizle
        GlobalDataManager.sharedGlobalManager.selectedBrand = "" // Seçilen markayı temizle
        brandPickerView.selectRow(0, inComponent: 0, animated: true) // PickerView'daki seçimi temizle
        isPickerViewShown = true
    }
    @objc func showBrandPickerView() {
        brandPickerView.isHidden = false
        categoryLabel.text = "Category" // Kategori seçimini temizle
        GlobalDataManager.sharedGlobalManager.selectedCategory = "" // Seçilen kategoriyi temizle
        categoryPickerView.selectRow(0, inComponent: 0, animated: true) // PickerView'daki seçimi temizle
        isBrandPickerViewShown = true
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
        if !filteredProductsName.isEmpty {
            return filteredProductsName.count
        } else if GlobalDataManager.sharedGlobalManager.selectedCategory == categoryLabel.text  {
            return GlobalDataManager.sharedGlobalManager.receiverName.count
        } else if GlobalDataManager.sharedGlobalManager.selectedBrand == brandLabel.text  {
            return GlobalDataManager.sharedGlobalManager.brandName.count
        } else {
            return GlobalDataManager.sharedGlobalManager.productListId?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let productCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        if !filteredProductsName.isEmpty {
            productCell.productNameLabel.text = filteredProductsName[indexPath.item]
            
            productCell.productCategoryLabel.text = GlobalDataManager.sharedGlobalManager.searchProductCategory[indexPath.item]
            productCell.productBrandLabel.text = GlobalDataManager.sharedGlobalManager.searchBrand[indexPath.item]
            let imageUrlString = GlobalDataManager.sharedGlobalManager.searchImage[indexPath.item]
            if let imageUrl = URL(string: imageUrlString) {
                productCell.productImage.kf.setImage(with: imageUrl)
            } else {
                let defaultImageUrlString = "skincare"
                let defaultImageUrl = URL(string: defaultImageUrlString)
                productCell.productImage.kf.setImage(with: defaultImageUrl)
            }
            
            return productCell
        } else if GlobalDataManager.sharedGlobalManager.selectedCategory == categoryLabel.text {
            productCell.productNameLabel.text = GlobalDataManager.sharedGlobalManager.receiverName[indexPath.item]
            productCell.productCategoryLabel.text = GlobalDataManager.sharedGlobalManager.receiverProductCategory[indexPath.item]
            productCell.productBrandLabel.text = GlobalDataManager.sharedGlobalManager.receiverBrand[indexPath.item]
            //        productCell.productTotalRatin.text = GlobalDataManager.sharedGlobalManager.productListTotalRating?[indexPath.item]
            let imageUrlString = GlobalDataManager.sharedGlobalManager.receiverImage[indexPath.item]
            if let imageUrl = URL(string: imageUrlString) {
                productCell.productImage.kf.setImage(with: imageUrl)
            } else {
                let defaultImageUrlString = "skincare"
                let defaultImageUrl = URL(string: defaultImageUrlString)
                productCell.productImage.kf.setImage(with: defaultImageUrl)
            }
            
            return productCell
        } else if GlobalDataManager.sharedGlobalManager.selectedBrand == brandLabel.text {
            productCell.productNameLabel.text = GlobalDataManager.sharedGlobalManager.brandName[indexPath.item]
            productCell.productCategoryLabel.text = GlobalDataManager.sharedGlobalManager.brandProductCategory[indexPath.item]
            productCell.productBrandLabel.text = GlobalDataManager.sharedGlobalManager.brandBrand[indexPath.item]
            //        productCell.productTotalRatin.text = GlobalDataManager.sharedGlobalManager.productListTotalRating?[indexPath.item]
            let imageUrlString = GlobalDataManager.sharedGlobalManager.brandImage[indexPath.item]
            if let imageUrl = URL(string: imageUrlString) {
                productCell.productImage.kf.setImage(with: imageUrl)
            } else {
                let defaultImageUrlString = "skincare"
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
                let defaultImageUrlString = "skincare"
                let defaultImageUrl = URL(string: defaultImageUrlString)
                productCell.productImage.kf.setImage(with: defaultImageUrl)
            }
            
            return productCell
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let productDetailVC = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            navigationController?.pushViewController(productDetailVC, animated: true)
            if !filteredProductsName.isEmpty {
                print(indexPath.item)
                productDetailVC.selectedProductId = GlobalDataManager.sharedGlobalManager.searchId[indexPath.item]
                GlobalDataManager.sharedGlobalManager.selectedProductId = GlobalDataManager.sharedGlobalManager.searchId[indexPath.item]
            } else if GlobalDataManager.sharedGlobalManager.selectedCategory == categoryLabel.text  {
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


extension SearchPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Arama metni her değiştiğinde filtrelemeyi uygula
        filterProducts(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Klavyede "Ara" düğmesine basıldığında klavyeyi gizle
        searchBar.resignFirstResponder()
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
        if pickerView == categoryPickerView {
            return pickerViewData.count
        } else {
            return brandPickerViewData.count
        }
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPickerView {
            return Array(pickerViewData)[row]
        } else {
            return Array(brandPickerViewData)[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
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
        } else if pickerView == brandPickerView {
            // Seçilen kategoriyi categoryLabel'a ata
            let selectedBrand = Array(brandPickerViewData)[row]
            GlobalDataManager.sharedGlobalManager.brandId = []
            GlobalDataManager.sharedGlobalManager.brandName = []
            GlobalDataManager.sharedGlobalManager.brandProductCategory = []
            GlobalDataManager.sharedGlobalManager.brandBrand = []
            GlobalDataManager.sharedGlobalManager.brandIngredients = []
            GlobalDataManager.sharedGlobalManager.brandImage = []
            GlobalDataManager.sharedGlobalManager.brandTotalRating = []
            GlobalDataManager.sharedGlobalManager.brandReviewNumbers = []
            brandLabel.text = selectedBrand
            
            // Seçilen değeri başka bir değişkende saklamak için aşağıdaki satırı ekleyebilirsiniz
            GlobalDataManager.sharedGlobalManager.selectedBrand = selectedBrand
            
            for (index, item) in brandsSet.enumerated() {
                if item == GlobalDataManager.sharedGlobalManager.selectedBrand {
                    for outerArray in GlobalDataManager.sharedGlobalManager.receiverBrands {
                        if let recieverIndex = GlobalDataManager.sharedGlobalManager.receiverBrands.firstIndex(of: outerArray) {
                            if recieverIndex == index {
                                // İç içe array'e girmek için burada işlemler yapabilirsiniz
                                print("İç içe array bulundu! İndeks: \(recieverIndex)")
                                // outerArray içindeki elemanlara erişebilirsiniz
                                for item in outerArray {
                                    print("Eleman: \(item)")
                                    GlobalDataManager.sharedGlobalManager.brandId.append(GlobalDataManager.sharedGlobalManager.productListId?[item] ?? "")
                                    GlobalDataManager.sharedGlobalManager.brandName.append(GlobalDataManager.sharedGlobalManager.productListName?[item] ?? "")
                                    GlobalDataManager.sharedGlobalManager.brandProductCategory.append(GlobalDataManager.sharedGlobalManager.productListCategories?[item] ?? "")
                                    GlobalDataManager.sharedGlobalManager.brandBrand.append(GlobalDataManager.sharedGlobalManager.productListBrand?[item] ?? "")
                                    GlobalDataManager.sharedGlobalManager.brandImage.append(GlobalDataManager.sharedGlobalManager.productListImage?[item] ?? "")
                                  
                                }
                            }
                        }
                    }

                }
            }
            
            // PickerView'i gizle
            brandPickerView.isHidden = true
            isBrandPickerViewShown = false
            productCollectionView.reloadData()
        }
       
    }
}

