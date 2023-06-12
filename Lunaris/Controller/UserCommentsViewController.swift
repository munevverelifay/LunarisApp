//
//  CommentPageViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.05.2023.
//

import Foundation
import UIKit
import Alamofire

class UserCommentsViewController: UIViewController {
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var commentButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentCollectionView.dataSource = self
        commentCollectionView.delegate = self
        commentCollectionView.register(UINib(nibName: String(describing: CommentCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CommentCell.self))
        commentCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        configureButton(btn: commentButton)
        
        title = "Comments"
        configureNavigationTitle() //ürünün adını gir
        commentCollectionView.reloadData()
//        GlobalDataManager.sharedGlobalManager.sendedProductId = ""
        commentCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        GlobalDataManager.sharedGlobalManager.commentId = []
        GlobalDataManager.sharedGlobalManager.commentUserId = []
        GlobalDataManager.sharedGlobalManager.commentContent = []
        GlobalDataManager.sharedGlobalManager.commentRatings = []
        GlobalDataManager.sharedGlobalManager.commentTitle = []
        GlobalDataManager.sharedGlobalManager.commentCreatedAt = []
        configureCommentData()
    }

    func configureCommentData() {
        GlobalDataManager.sharedGlobalManager.sendedProductId = String((Int(GlobalDataManager.sharedGlobalManager.selectedProductId) ?? 0) + 1)
        NetworkService.sharedNetwork.getReviewList(product_id: GlobalDataManager.sharedGlobalManager.sendedProductId) { response in
            switch response{
            case .success(let reviews):
                    reviews.forEach { item in
                        GlobalDataManager.sharedGlobalManager.commentId?.append(item.id)
                    
                        GlobalDataManager.sharedGlobalManager.commentUserId?.append(item.userId)
                        GlobalDataManager.sharedGlobalManager.commentContent?.append(item.commentContent)
                        GlobalDataManager.sharedGlobalManager.commentRatings?.append(item.commentRatings)
                        GlobalDataManager.sharedGlobalManager.commentTitle?.append(item.commentTitle)
                        GlobalDataManager.sharedGlobalManager.commentCreatedAt?.append(item.createdAt)
                        GlobalDataManager.sharedGlobalManager.commentUserName?.append(item.name)
                        GlobalDataManager.sharedGlobalManager.commentUserSurname?.append(item.surname)
                        self.commentCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }

        }
    }
    
    @IBAction func addCommentButton(_ sender: UIButton) {
        
        if let sendCodeVC = storyboard?.instantiateViewController(withIdentifier: "AddCommentViewController") as? AddCommentViewController {
            self.navigationController?.pushViewController(sendCodeVC, animated: true)
            navigationController?.isNavigationBarHidden = false
        }
    }
}

extension UserCommentsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalDataManager.sharedGlobalManager.commentId?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let commentCell = commentCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CommentCell.self), for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        if let name = GlobalDataManager.sharedGlobalManager.commentUserName?[indexPath.item],
           let surname = GlobalDataManager.sharedGlobalManager.commentUserSurname?[indexPath.item] {
            commentCell.userNameLabel.text = "\(name) \(surname)"
        }
        commentCell.commentDateLabel.text = GlobalDataManager.sharedGlobalManager.commentCreatedAt?[indexPath.item]
        commentCell.commentLabel.text = GlobalDataManager.sharedGlobalManager.commentContent?[indexPath.item]
        commentCell.commentTitleLabel.text = GlobalDataManager.sharedGlobalManager.commentTitle?[indexPath.item]
        
        let commentRating = GlobalDataManager.sharedGlobalManager.commentRatings?[indexPath.item] ?? ""
        
        if commentRating == "0" {
            commentCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.firstStarImage.image = UIImage(systemName: "star")
            commentCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.secondStarImage.image = UIImage(systemName: "star")
            commentCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.thirdStarImage.image = UIImage(systemName: "star")
            commentCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fourthStarImage.image = UIImage(systemName: "star")
            commentCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fifthStarImage.image = UIImage(systemName: "star")
        }
        else if commentRating == "1" {
            commentCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.firstStarImage.image = UIImage(systemName: "star.fill")
            commentCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.secondStarImage.image = UIImage(systemName: "star")
            commentCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.thirdStarImage.image = UIImage(systemName: "star")
            commentCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fourthStarImage.image = UIImage(systemName: "star")
            commentCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fifthStarImage.image = UIImage(systemName: "star")
        }else if commentRating == "2" {
            commentCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.firstStarImage.image = UIImage(systemName: "star.fill")
            commentCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.secondStarImage.image = UIImage(systemName: "star.fill")
            commentCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.thirdStarImage.image = UIImage(systemName: "star")
            commentCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fourthStarImage.image = UIImage(systemName: "star")
            commentCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fifthStarImage.image = UIImage(systemName: "star")
        } else if commentRating == "3" {
            commentCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.firstStarImage.image = UIImage(systemName: "star.fill")
            commentCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.secondStarImage.image = UIImage(systemName: "star.fill")
            commentCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.thirdStarImage.image = UIImage(systemName: "star.fill")
            commentCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fourthStarImage.image = UIImage(systemName: "star")
            commentCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fifthStarImage.image = UIImage(systemName: "star")
        } else if commentRating == "4" {
            commentCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.firstStarImage.image = UIImage(systemName: "star.fill")
            commentCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.secondStarImage.image = UIImage(systemName: "star.fill")
            commentCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.thirdStarImage.image = UIImage(systemName: "star.fill")
            commentCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fourthStarImage.image = UIImage(systemName: "star.fill")
            commentCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fifthStarImage.image = UIImage(systemName: "star")
        } else if commentRating == "5" {
            commentCell.firstStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.firstStarImage.image = UIImage(systemName: "star.fill")
            commentCell.secondStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.secondStarImage.image = UIImage(systemName: "star.fill")
            commentCell.thirdStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.thirdStarImage.image = UIImage(systemName: "star.fill")
            commentCell.fourthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fourthStarImage.image = UIImage(systemName: "star.fill")
            commentCell.fifthStarImage.tintColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            commentCell.fifthStarImage.image = UIImage(systemName: "star.fill")
        }
        
        return commentCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
    }
}

extension UserCommentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 384, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
