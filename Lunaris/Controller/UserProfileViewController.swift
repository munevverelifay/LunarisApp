//
//  UserProfileViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 21.05.2023.
//

import UIKit
import FSCalendar

class UserProfileViewController: UIViewController {
    @IBOutlet weak var profilePictureIV: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBirthDateLabel: UILabel!
    @IBOutlet weak var profileDescriptonLabel: UILabel!
    @IBOutlet weak var profileSectionsCollectionView: UICollectionView!
    @IBOutlet weak var dividingLineView: UIView!
    @IBOutlet weak var routineView: UIView!
    @IBOutlet weak var routineTableView: UITableView!
    @IBOutlet weak var weeklyFSCalendarView: FSCalendar!
    
    var formatter = DateFormatter()
    var calendarHeightConstraint: NSLayoutConstraint?
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weeklyFSCalendarView.delegate = self
        weeklyFSCalendarView.dataSource = self
        configureWeeklyCalendar(calendar: weeklyFSCalendarView)
        applyShadowOnView(weeklyFSCalendarView)
        weeklyFSCalendarView.layer.cornerRadius = weeklyFSCalendarView.frame.height / 10
        
        configureUserProfilImage(userProfil: profilePictureIV)
        
        profileSectionsCollectionView.dataSource = self
        profileSectionsCollectionView.delegate = self
        profileSectionsCollectionView.register(UINib(nibName: String(describing: ProfileSectionsCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProfileSectionsCell.self))
        profileSectionsCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        routineTableView.dataSource = self
        routineTableView.delegate = self
        routineTableView.layer.cornerRadius = 20
        routineTableView.register(UITableViewCell.self, forCellReuseIdentifier: "RoutineCell")
        routineTableView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        title = "Profile"
        configureNavigationTitle()
        
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

extension UserProfileViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func configureWeeklyCalendar(calendar: FSCalendar?) {
        if let calendar = calendar {
            
            calendarHeightConstraint = weeklyFSCalendarView.heightAnchor.constraint(equalToConstant: 300)
            calendarHeightConstraint?.isActive = true
            
            calendar.scrollDirection = .horizontal
            calendar.setScope(.week, animated: false)
    
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            calendar.addGestureRecognizer(panGesture)

            calendar.locale = Locale(identifier: "en") // BU SATIRI CİHAZ DİLİNE GÖRE YAP
            
            // Calendar appearance
            calendar.appearance.headerMinimumDissolvedAlpha = 0.0
            calendar.appearance.borderDefaultColor = .clear
            calendar.appearance.borderSelectionColor = .clear
            


            // Offset'i ayarla ve görüntü ve renk ayarlarını da uygula
//            calendar.appearance.headerTitleOffset = offset
            calendar.appearance.headerTitleColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            calendar.appearance.weekdayTextColor = UIColor(red: 176/255, green: 176/255, blue: 176/255, alpha: 1.0)
            calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 19.0)
            calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            
            calendar.appearance.todayColor = .clear
            calendar.appearance.titleTodayColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            
            calendar.appearance.selectionColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)

         
        }
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if translation.y > 0 {
            // aşağı hareket - aylık takvime geçiş
            weeklyFSCalendarView.setScope(.month, animated: true)
        } else {
            // yukarı hareket - haftalık takvime geçiş
            weeklyFSCalendarView.setScope(.week, animated: true)
        }
    }

    //MARK: - Delegate Func
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Date Selected == \(formatter.string(from: date))")
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        // Aşağıdaki satırı ekleyin:
        self.calendarHeightConstraint?.constant = bounds.height
        
    }
}

extension UIViewController {
    func applyShadowOnView(_ view: UIView) {
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor =   UIColor(red: 90/255, green: 108/255, blue: 234/255, alpha: 1).cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 2, height: 1)
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

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3 // Morning section
        } else {
            return 1 // Evening section
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath)
        cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        if indexPath.section == 0 {
            // Morning section
            if indexPath.row == 0 {
                cell.textLabel?.text = "1. Step: Cerave"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "2. Step: Rice Toner"
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "3. Step: Dalba"
            }
        } else {
            // Evening section
            cell.textLabel?.text = "1. Step: Purito"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        let morningColor = UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0)
        let eveningColor = UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0)
        let font = UIFont(name: "Bodoni 72 Bold", size: 23)
        
        headerView.backgroundColor = UIColor.clear
        
        // Create UIImageView for the icon
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(iconImageView)
        
        // Add constraints for the iconImageView
        iconImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        titleLabel.font = font
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        if section == 0 {
            titleLabel.text = "Morning"
            titleLabel.textColor = morningColor
            iconImageView.image = UIImage(systemName: "sun.max")
            iconImageView.tintColor = morningColor
        } else {
            titleLabel.text = "Evening"
            titleLabel.textColor = eveningColor
            iconImageView.image = UIImage(systemName: "moon")
            iconImageView.tintColor = eveningColor
        }
        
        return headerView
    }

}


extension UIViewController {
    func configureUserProfilImage(userProfil: UIImageView) {
        userProfil.layer.cornerRadius = userProfil.frame.height / 2
        userProfil.layer.borderWidth = 5
        let profileBorderColor = UIColor(red: 244/255, green: 241/255, blue: 222/255, alpha: 1.0)
        userProfil.layer.borderColor = profileBorderColor.cgColor
    }
    
    func configureNavigationTitle() {
//        if let font = UIFont(name: "Bodoni 72 Book", size: 22) {
//            navigationController?.navigationBar.titleTextAttributes = [
//                NSAttributedString.Key.font: font
//            ]
//        }
//
        navigationController?.navigationBar.tintColor = UIColor(red: 249/255, green: 36/255, blue: 87/255, alpha: 1.0)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 249/255, green: 36/255, blue: 87/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

