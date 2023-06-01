//
//  UserProfileViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 21.05.2023.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var profilePictureIV: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBirthDateLabel: UILabel!
    @IBOutlet weak var profileDescriptonLabel: UILabel!
    @IBOutlet weak var profileSectionsCollectionView: UICollectionView!
    @IBOutlet weak var dividingLineView: UIView!
    @IBOutlet weak var selectedSectionCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUserProfilImage(userProfil: profilePictureIV)
        
        profileSectionsCollectionView.dataSource = self
        profileSectionsCollectionView.delegate = self
        profileSectionsCollectionView.register(UINib(nibName: String(describing: ProfileSectionsCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProfileSectionsCell.self))
        profileSectionsCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        configureNavigationTitle(pageTitle: "Profile")
        
        if let imageUrlString = UserDefaults.standard.string(forKey: "userProfileImageURL"), let imageUrl = URL(string: imageUrlString) {
            profilePictureIV.kf.setImage(with: imageUrl)
        }
        userNameLabel.text = GlobalDataManager.sharedGlobalManager.userSurname
        userBirthDateLabel.text = GlobalDataManager.sharedGlobalManager.userDateOfBirth
//        profileDescriptonLabel.text = userDescription
        let imageUrl = URL(string: GlobalDataManager.sharedGlobalManager.profileImage ?? "")
        profilePictureIV.kf.setImage(with: imageUrl)
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
    }
    
    
    @IBAction func editButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
            navigationController?.pushViewController(editProfileVC, animated: true)
        }
    }
}

extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        guard let profileSectionsCell = profileSectionsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileSectionsCell.self), for: indexPath) as? ProfileSectionsCell else {
            return UICollectionViewCell()

        }
        
        return profileSectionsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let profileSectionCell = collectionView.cellForItem(at: indexPath) as? ProfileSectionsCell {
            // Seçili hücrenin arka plan rengini değiştir
            profileSectionCell.profileSectionNameLabel.textColor = UIColor(red: 55/255, green: 41/255, blue: 77/255, alpha: 1.0)
            profileSectionCell.profileSectionSelectedView.backgroundColor = UIColor(red: 55/255, green: 41/255, blue: 77/255, alpha: 1.0)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let profileSectionCell = collectionView.cellForItem(at: indexPath) as? ProfileSectionsCell {
            // Seçili hücrenin arka plan rengini değiştir
            profileSectionCell.profileSectionNameLabel.textColor = UIColor(red: 176/255, green: 176/255, blue: 176/255, alpha: 1.0)
            profileSectionCell.profileSectionSelectedView.backgroundColor = UIColor.white
        }
    }
}


extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
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
    
    func configureNavigationTitle(pageTitle: String?) {
        title = pageTitle
        // Navigation bar başlığını sola yasla
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 55/255, green: 41/255, blue: 77/255, alpha: 1.0)]
        
        // Navigation bar başlığı için özel bir font ve boyut belirle
        if let font = UIFont(name: "Bodoni 72 Book", size: 25) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: font
            ]
        }
    
    }
}
