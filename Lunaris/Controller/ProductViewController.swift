//
//  ProductViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 30.04.2023.
//

import Foundation
import UIKit
import Kingfisher

struct cellData {
    var opened = Bool()
    var title = String()
}

class ProductViewController : UIViewController {
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productBrandNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productTotalCommentLabel: UILabel!
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    
    var favoriteProductsString: String = ""
    
    var tableViewData = [cellData]()
    
    var selectedProductId: String = ""
    
    var productListTotalRating: String = "0"
    
    var isFavorite: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.layer.cornerRadius = 30
        
        productImage.layer.applySketchShadow(color: UIColor.black, alpha: 0.01, x: 2, y: 2, blur: 10, spread: 0)
        productImage.layer.masksToBounds = true
        
        
        productNameLabel.text = GlobalDataManager.sharedGlobalManager.productListName?[Int(selectedProductId) ?? 0]
        productBrandNameLabel.text = GlobalDataManager.sharedGlobalManager.productListBrand?[Int(selectedProductId) ?? 0]
        productCategoryLabel.text = GlobalDataManager.sharedGlobalManager.productListCategories?[(Int(selectedProductId) ?? 0)]
        if let imageUrlString = GlobalDataManager.sharedGlobalManager.productListImage?[Int(selectedProductId) ?? 0],
           let imageUrl = URL(string: imageUrlString) {
            productImage.kf.setImage(with: imageUrl)
        } else {
            let defaultImageUrlString = "skincare"
            let defaultImageUrl = URL(string: defaultImageUrlString)
            productImage.kf.setImage(with: defaultImageUrl)
        }
        
        navigationController?.isNavigationBarHidden = false
        title = "Products"
        configureNavigationTitle() //ürünün adını gir
        
        
        // Boş bir dizi ile tableViewData'yı başlatma
        tableViewData = []
        
        // TableView'i veri kaynağı ve delegesi olarak ayarlama
        productTableView.dataSource = self
        productTableView.delegate = self
        
        // Cell'leri kaydolma
        productTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        productTableView.register(UINib(nibName: String(describing: ReviewsCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ReviewsCell.self))
        
        productTableView.backgroundColor = .clear
        
        
        tableViewData = [
            cellData(opened: false, title: "Ingredients"),
            cellData(opened: false, title: "Comments")
        ]
        
        configureLikeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let reviewNumberString = GlobalDataManager.sharedGlobalManager.productListReviewNumbers?[Int(selectedProductId) ?? 0] {
            productTotalCommentLabel.text = String(reviewNumberString)
        
        }

        productListTotalRating = GlobalDataManager.sharedGlobalManager.productListTotalRating?[Int(selectedProductId) ?? 0] ?? "0.00"
        
        productRatingStar()

    }
    
    
    func configureLikeButton() {
        if GlobalDataManager.sharedGlobalManager.favoriteProductsList.contains(selectedProductId) {
            let filledHeartImage = UIImage(systemName: "heart.fill")
            likeButton.setImage(filledHeartImage, for: .normal)
        } else {
            let emptyHeartImage = UIImage(systemName: "heart")
            likeButton.setImage(emptyHeartImage, for: .normal)
        }
    }
    
    
    func productRatingStar() {
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
        else if Double(productListTotalRating) ?? 0.1 <= 0.75 {
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
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        isFavorite = GlobalDataManager.sharedGlobalManager.favoriteProductsList.contains(selectedProductId)

        if !isFavorite {
            // Favori ise, postRemoveFavorite işlemini gerçekleştirin
            NetworkService.sharedNetwork.postFavorites(userId: GlobalDataManager.sharedGlobalManager.userId, productId: selectedProductId) { response in
                switch response {
                case .success(let value):
                    if let data = value.data(using: .utf8),
                       let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                       let result = json.first?["result"] as? String {
                        print(result)
                        if result == "true" {
                            print("postRemoveFavorite")
                            self.isFavorite = true
                            let filledHeartImage = UIImage(systemName: "heart.fill")
                            self.likeButton.setImage(filledHeartImage, for: .normal)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            // Favori değilse, postFavorites işlemini gerçekleştirin
            NetworkService.sharedNetwork.postRemoveFavorite(userId: GlobalDataManager.sharedGlobalManager.userId, productId: selectedProductId) { response in
                switch response {
                case .success(let value):
                    if let data = value.data(using: .utf8),
                       let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                       let result = json.first?["result"] as? String {
                        print(result)
                        if result == "true" {
                            print("postFavorites")
                            let emptyHeartImage = UIImage(systemName: "heart")
                            self.likeButton.setImage(emptyHeartImage, for: .normal)
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}


extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.backgroundColor = .clear
            return cell
        } else if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            cell.textLabel?.text = GlobalDataManager.sharedGlobalManager.productListIngredients?[Int(selectedProductId) ?? 0]
            //            tableViewData[indexPath.section].sectionData
            cell.textLabel?.numberOfLines = 0
            cell.backgroundColor = .clear
            cell.textLabel?.sizeToFit()
            return cell
        } else {
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewsCell.self)) as? ReviewsCell else { return UITableViewCell() }
            reviewCell.backgroundColor = .clear
            
            if Double(productListTotalRating) ?? 0.0 == 0.0 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "0.0"
            }
            else if Double(productListTotalRating) ?? 0.1 <= 0.75 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "0.5"
            }else if Double(productListTotalRating) ?? 0 <= 1.25 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "1.0"
            } else if Double(productListTotalRating) ?? 0 <= 1.75 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "1.5"
            } else if Double(productListTotalRating) ?? 0 <= 2.25 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "2.0"
            } else if Double(productListTotalRating) ?? 0 <= 2.75 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "2.5"
            } else if Double(productListTotalRating) ?? 0 <= 3.25 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "3.0"
            } else if Double(productListTotalRating) ?? 0 <= 3.75 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "3.5"
            } else if Double(productListTotalRating) ?? 0 <= 4.25 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "4.0"
            } else if Double(productListTotalRating) ?? 0 <= 4.75 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star.leadinghalf.filled")
                reviewCell.ratingLabel.text = "4.5"
            } else if Double(productListTotalRating) ?? 0 <= 5 {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star.fill")
                reviewCell.ratingLabel.text = "5.0"
            } else {
                reviewCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.firstStarImage.image = UIImage(systemName: "star")
                reviewCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.secondStarImage.image = UIImage(systemName: "star")
                reviewCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.thirdStarImage.image = UIImage(systemName: "star")
                reviewCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fourthStarImage.image = UIImage(systemName: "star")
                reviewCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                reviewCell.fifthStarImage.image = UIImage(systemName: "star")
                reviewCell.ratingLabel.text = "0.0"
            }
        
            return reviewCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 1 {
            // İlgili hücre seçildiğinde başka bir ekrana geçmek için kodları buraya yazın.
            if let commentCV = storyboard?.instantiateViewController(withIdentifier: "CommentPageViewController") as? UserCommentsViewController {
                self.navigationController?.pushViewController(commentCV, animated: true)
                navigationController?.isNavigationBarHidden = false
            }
            
        } else if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                cell.accessoryView = UIImageView(image: UIImage(named: "up-arrow"))
            } else {
                cell.accessoryView = UIImageView(image: UIImage(named: "down-arrow"))
            }
        }
    }
    

}
