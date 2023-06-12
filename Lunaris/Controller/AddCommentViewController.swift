//
//  AddCommentViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.05.2023.
//

import Foundation
import UIKit
import Alamofire

class AddCommentViewController: UIViewController {
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    @IBOutlet weak var reviewTitleTextField: UITextField!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var saveCommentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton(btn: saveCommentButton)
        title = "Add Comment"
        configureNavigationTitle() //ürünün adını gir
        tapGesture()
    }
    
    func tapGesture() {
        // Her image view için tek bir dokunma tanımlayıcısı oluşturun
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapStarImage(_:)))
        tapGesture.numberOfTapsRequired = 1
        
        // Image view'lere tanımlayıcısı ekle
        let firstTap = UITapGestureRecognizer(target: self, action: #selector(didTapStarImage(_:)))
        firstStarImage.isUserInteractionEnabled = true
        firstStarImage.addGestureRecognizer(firstTap)
        
        let secondTap = UITapGestureRecognizer(target: self, action: #selector(didTapStarImage(_:)))
        secondStarImage.isUserInteractionEnabled = true
        secondStarImage.addGestureRecognizer(secondTap)
        
        let thirdTap = UITapGestureRecognizer(target: self, action: #selector(didTapStarImage(_:)))
        thirdStarImage.isUserInteractionEnabled = true
        thirdStarImage.addGestureRecognizer(thirdTap)
        
        let fourthTap = UITapGestureRecognizer(target: self, action: #selector(didTapStarImage(_:)))
        fourthStarImage.isUserInteractionEnabled = true
        fourthStarImage.addGestureRecognizer(fourthTap)
        
        let fifthTap = UITapGestureRecognizer(target: self, action: #selector(didTapStarImage(_:)))
        fifthStarImage.isUserInteractionEnabled = true
        fifthStarImage.addGestureRecognizer(fifthTap)
        
    }
    
    //MARK: - PostComment
    @IBAction func saveCommentButton(_ sender: UIButton) {
        NetworkService.sharedNetwork.postComment(userId: GlobalDataManager.sharedGlobalManager.userId,
                                                 productId: GlobalDataManager.sharedGlobalManager.sendedProductId ,
                                                 commentContentTxt: reviewTextField.text,
                                                 commentRatings: GlobalDataManager.sharedGlobalManager.userProductRating,
                                                 commentTitle: reviewTitleTextField.text) { response in
            switch response {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
                    print(result)
                    if result == "true" {
                          let alertController = UIAlertController(title: "Success", message: "Your comment has been saved.", preferredStyle: .alert)
                          let okayAction = UIAlertAction(title: "Okay", style: .default) { (_) in
                              GlobalDataManager.sharedGlobalManager.productListId = []
                              GlobalDataManager.sharedGlobalManager.productListName = []
                              GlobalDataManager.sharedGlobalManager.productListCategories = []
                              GlobalDataManager.sharedGlobalManager.productListBrand = []
                              GlobalDataManager.sharedGlobalManager.productListIngredients = []
                              GlobalDataManager.sharedGlobalManager.productListImage = []
                              GlobalDataManager.sharedGlobalManager.productListTotalRating = []
                              GlobalDataManager.sharedGlobalManager.productListReviewNumbers = []

                              self.configureProductData()
                              // DailyRoutineViewController sayfasına geri dön
                              self.navigationController?.popViewController(animated: true)
                          }
                          alertController.addAction(okayAction)
                        self.present(alertController, animated: true, completion: nil)

                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureProductData () {
        NetworkService.sharedNetwork.getProductList { response in
            switch response{
            case .success(let value):
                print(value[0].id)
                value.forEach { item in
                    let productId = String((Int(item.id) ?? 0) - 1)
                    GlobalDataManager.sharedGlobalManager.productListId?.append(productId)
                    GlobalDataManager.sharedGlobalManager.productListBrand?.append(item.productBrand)
                    GlobalDataManager.sharedGlobalManager.productListName?.append(item.productName)
                    
                    
                    if let productListBrand = GlobalDataManager.sharedGlobalManager.productListBrand,
                       let productListName = GlobalDataManager.sharedGlobalManager.productListName {
                        for index in 0..<productListName.count {
                            if let productBrand = productListBrand[safe: index] {
                                let newProductName = productListName[index].replacingOccurrences(of: productBrand, with: "").trimmingCharacters(in: .whitespaces)
                                GlobalDataManager.sharedGlobalManager.productListName?[index] = newProductName
                            }
                        }
                    }
                    
                    GlobalDataManager.sharedGlobalManager.productListCategories?.append(item.productCategories)
                    GlobalDataManager.sharedGlobalManager.productListIngredients?.append(item.productIndrigients)
                    GlobalDataManager.sharedGlobalManager.productListImage?.append(item.productImage)
                    GlobalDataManager.sharedGlobalManager.productListTotalRating?.append(item.productTotalRating)
                    GlobalDataManager.sharedGlobalManager.productListReviewNumbers?.append(item.productReviewNumbers)
                }
            case .failure(let error):
                print(error)
            }
        }
    }}

extension AddCommentViewController {
    @objc func didTapStarImage(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            imageView.image = UIImage(systemName: "star.fill")
            imageView.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            
            if imageView == firstStarImage {
                firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                print("1 Star")
                GlobalDataManager.sharedGlobalManager.userProductRating = "1"
                                
            }else if imageView == secondStarImage {
                firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                print("2 Star")
                GlobalDataManager.sharedGlobalManager.userProductRating = "2"
                                
            } else if imageView == thirdStarImage {
                
                firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                print("3 Star")
                GlobalDataManager.sharedGlobalManager.userProductRating = "3"

            } else if imageView == fourthStarImage {
                firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 0.3)
                print("4 Star")
                GlobalDataManager.sharedGlobalManager.userProductRating = "4"
            }else if imageView == fifthStarImage {
                firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                print("5 Star")
                GlobalDataManager.sharedGlobalManager.userProductRating = "5"
            }
        }
    }
}


