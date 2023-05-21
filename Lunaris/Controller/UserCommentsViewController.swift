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
        
        GlobalDataManager.sharedGlobalManager.commentId = []
        GlobalDataManager.sharedGlobalManager.commentUserId = []
        GlobalDataManager.sharedGlobalManager.commentContent = []
        GlobalDataManager.sharedGlobalManager.commentRatings = []
        GlobalDataManager.sharedGlobalManager.commentTitle = []
        GlobalDataManager.sharedGlobalManager.commentCreatedAt = []
        commentCollectionView.reloadData()
        configureCommentData()
        commentCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        GlobalDataManager.sharedGlobalManager.commentId = []
//        GlobalDataManager.sharedGlobalManager.commentUserId = []
//        GlobalDataManager.sharedGlobalManager.commentContent = []
//        GlobalDataManager.sharedGlobalManager.commentRatings = []
//        GlobalDataManager.sharedGlobalManager.commentTitle = []
//        GlobalDataManager.sharedGlobalManager.commentCreatedAt = []
//        commentCollectionView.reloadData()
//        configureCommentData()
        
    }

    func configureCommentData() {

        NetworkService.sharedNetwork.getReviewList(product_id: GlobalDataManager.sharedGlobalManager.selectedProductId) { response in
            switch response{
            case .success(let reviews):
                    reviews.forEach { item in
                        GlobalDataManager.sharedGlobalManager.commentId?.append(item.id)
                    
                        GlobalDataManager.sharedGlobalManager.commentUserId?.append(item.userId)
                        GlobalDataManager.sharedGlobalManager.commentContent?.append(item.commentContent)
                        GlobalDataManager.sharedGlobalManager.commentRatings?.append(item.commentRatings)
                        GlobalDataManager.sharedGlobalManager.commentTitle?.append(item.commentTitle)
                        GlobalDataManager.sharedGlobalManager.commentCreatedAt?.append(item.createdAt)
                        
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
        commentCell.userNameLabel.text = GlobalDataManager.sharedGlobalManager.commentUserId?[indexPath.item]
        commentCell.commentDateLabel.text = GlobalDataManager.sharedGlobalManager.commentCreatedAt?[indexPath.item]
        commentCell.commentLabel.text = GlobalDataManager.sharedGlobalManager.commentContent?[indexPath.item]
        commentCell.commentTitleLabel.text = GlobalDataManager.sharedGlobalManager.commentTitle?[indexPath.item]
        
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
