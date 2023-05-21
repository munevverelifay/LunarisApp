//
//  ProfileViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 8.04.2023.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileCoverImage: UIImageView!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var followedLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var favoriteProductsLabel: UILabel!
    @IBOutlet weak var favoriteProductsCollectionView: UICollectionView!
    @IBOutlet weak var currentlyUsedProductsLabel: UILabel!
    @IBOutlet weak var currentlyUsedProductsCollectionView: UICollectionView!
    @IBOutlet weak var wishlistLabel: UILabel!
    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    @IBOutlet weak var finishedProductsLabel: UILabel!
    @IBOutlet weak var finishedProductsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        
        configureUserProfilImage(userProfil: profilePictureImage)
        
//        profileEditButton.layer.cornerRadius = profileEditButton.frame.height / 2
        configureButton(btn: profileEditButton)
        
        configureSetupCollectionView(cv: favoriteProductsCollectionView)
        configureSetupCollectionView(cv: currentlyUsedProductsCollectionView)
        configureSetupCollectionView(cv: wishlistCollectionView)
        configureSetupCollectionView(cv: finishedProductsCollectionView)
        

        if let imageUrlString = UserDefaults.standard.string(forKey: "userProfileImageURL"), let imageUrl = URL(string: imageUrlString) {
            profilePictureImage.kf.setImage(with: imageUrl)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func profileEditButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
            navigationController?.pushViewController(editProfileVC, animated: true)
        }
    }
}
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard favoriteProductsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileProductCell.self), for: indexPath) is ProfileProductCell else {
            return UICollectionViewCell()
        }
        
        guard let profileProductCell = currentlyUsedProductsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileProductCell.self), for: indexPath) as? ProfileProductCell else {
            return UICollectionViewCell()
        }
        
        return profileProductCell
    }
    
    func configureSetupCollectionView(cv: UICollectionView) {
        cv.dataSource = self
        cv.delegate = self
        cv.register(UINib(nibName: String(describing: ProfileProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProfileProductCell.self))
        cv.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
}

extension UIViewController {
    func configureUserProfilImage(userProfil: UIImageView) {
        userProfil.layer.cornerRadius = userProfil.frame.height / 2
        userProfil.layer.borderWidth = 5
        let profileBorderColor = UIColor(red: 244/255, green: 241/255, blue: 222/255, alpha: 1.0)
        userProfil.layer.borderColor = profileBorderColor.cgColor
    }
}
