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
    @IBOutlet weak var dividingLineView: UIView!
    
    @IBOutlet weak var routineTableView: UITableView!
    @IBOutlet weak var weeklyFSCalendarView: FSCalendar!
    
    var formatter = DateFormatter()
    var calendarHeightConstraint: NSLayoutConstraint?
    var timer: Timer?
    
    var routineDay: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weeklyFSCalendarView.delegate = self
        weeklyFSCalendarView.dataSource = self
        configureWeeklyCalendar(calendar: weeklyFSCalendarView)
        applyShadowOnView(weeklyFSCalendarView)
        weeklyFSCalendarView.layer.cornerRadius = weeklyFSCalendarView.frame.height / 10
        
        
        
        routineTableView.dataSource = self
        routineTableView.delegate = self
        routineTableView.layer.cornerRadius = 20
        routineTableView.register(UITableViewCell.self, forCellReuseIdentifier: "RoutineCell")
        routineTableView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        title = "Profile"
        configureNavigationTitle()
        if let userSurname = GlobalDataManager.sharedGlobalManager.userSurname,
           let userName = GlobalDataManager.sharedGlobalManager.userName {
            userNameLabel.text = "\(userName) \(userSurname)"
        } else {
            userNameLabel.text = ""
        }
        
        userBirthDateLabel.text = GlobalDataManager.sharedGlobalManager.userDateOfBirth
        
        // Add Logout Button to Navigation Bar
        let logoutButton = UIBarButtonItem(image: UIImage(systemName: "power"), style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = logoutButton
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let currentDayOfWeek = getDayOfWeek()
        routineDay = currentDayOfWeek
        
        // Herhangi bir tıklama yapmadan önceki günü temizle
        if let selectedDate = weeklyFSCalendarView.selectedDate {
            weeklyFSCalendarView.deselect(selectedDate)
        }
        
        routineTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureRoutineData()
        routineTableView.reloadData()
    }
    
    func getDayOfWeek() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US")
        let dayOfWeekString = dateFormatter.string(from: date)
        return dayOfWeekString
    }
    func configureRoutineData() {
        NetworkService.sharedNetwork.getRoutineList(userId: GlobalDataManager.sharedGlobalManager.userId) { response in
            switch response {
            case .success(let routines):
                if routines.indices.contains(0) {
                    let firstRoutine = routines[0]
                    // Birinci rutin
                    GlobalDataManager.sharedGlobalManager.mon1 = firstRoutine.mon.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.tue1 = firstRoutine.tue.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.wed1 = firstRoutine.wed.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.thu1 = firstRoutine.thu.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.fri1 = firstRoutine.fri.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.sat1 = firstRoutine.sat.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.sun1 = firstRoutine.sun.filter{ !$0.isEmpty }
                } else {
                    
                    print("Birinci rutin bulunamadı.")
                }
                
                if routines.indices.contains(1) {
                    let secondRoutine = routines[1]
                    // İkinci rutin
                    GlobalDataManager.sharedGlobalManager.mon2 = secondRoutine.mon.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.tue2 = secondRoutine.tue.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.wed2 = secondRoutine.wed.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.thu2 = secondRoutine.thu.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.fri2 = secondRoutine.fri.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.sat2 = secondRoutine.sat.filter{ !$0.isEmpty }
                    GlobalDataManager.sharedGlobalManager.sun2 = secondRoutine.sun.filter{ !$0.isEmpty }
                } else {
                    // İndeks 1 yoksa uygun hata işleme stratejisini uygulayabilirsiniz
                    print("İkinci rutin bulunamadı.")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logout() {
        
        // GlobalDataManager'ın resetData() metodu çağrılıyor
        GlobalDataManager.sharedGlobalManager.resetData()
        // UserDefaults'ta isLoggedIn değerini false olarak güncelle
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UIApplication.restartApplication()
    }
    
    
    @IBAction func editButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
            navigationController?.pushViewController(editProfileVC, animated: true)
        }
    }
    
    @objc func logoutButtonTapped() {
        
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            self.logout()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(logOutAction)
        
        present(alertController, animated: true, completion: nil)
        
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // Gün adını almak için "EEEE" formatı kullanılır
        dateFormatter.locale = Locale(identifier: "en_US") // İngilizce olarak ayarla
        let dayOfWeek = dateFormatter.string(from: date)
        
        routineDay = dayOfWeek
        routineTableView.reloadData()
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


extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            switch routineDay { // Morning section
            case "Monday":
                return GlobalDataManager.sharedGlobalManager.mon1.count
            case "Tuesday":
                return GlobalDataManager.sharedGlobalManager.tue1.count
            case "Wednesday":
                return GlobalDataManager.sharedGlobalManager.wed1.count
            case "Thursday":
                return GlobalDataManager.sharedGlobalManager.thu1.count
            case "Friday":
                return GlobalDataManager.sharedGlobalManager.fri1.count
            case "Saturday":
                return GlobalDataManager.sharedGlobalManager.sat1.count
            case "Sunday":
                return GlobalDataManager.sharedGlobalManager.sun1.count
            default:
                return 0
            }
        } else {
            switch routineDay { // Evening section
            case "Monday":
                return GlobalDataManager.sharedGlobalManager.mon2.count
            case "Tuesday":
                return GlobalDataManager.sharedGlobalManager.tue2.count
            case "Wednesday":
                return GlobalDataManager.sharedGlobalManager.wed2.count
            case "Thursday":
                return GlobalDataManager.sharedGlobalManager.thu2.count
            case "Friday":
                return GlobalDataManager.sharedGlobalManager.fri2.count
            case "Saturday":
                return GlobalDataManager.sharedGlobalManager.sat2.count
            case "Sunday":
                return GlobalDataManager.sharedGlobalManager.sun2.count
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let routineCell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath)
        routineCell.backgroundColor = UIColor.clear.withAlphaComponent(0)
        if indexPath.section == 0 {
            // Morning section
            switch routineDay {
            case "Monday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.mon1, cell: routineCell, color: UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0))
            case "Tuesday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.tue1, cell: routineCell, color: UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0))
            case "Wednesday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.wed1, cell: routineCell, color: UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0))
            case "Thursday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.thu1, cell: routineCell, color: UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0))
            case "Friday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.fri1, cell: routineCell, color: UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0))
            case "Saturday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.sat1, cell: routineCell, color: UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0))
            case "Sunday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.sun1, cell: routineCell, color: UIColor(red: 250/255, green: 180/255, blue: 88/255, alpha: 1.0))
            default:
                break
            }
        } else {
            // Evening section
            switch routineDay {
            case "Monday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.mon2, cell: routineCell, color: UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0))
            case "Tuesday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.tue2, cell: routineCell, color: UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0))
            case "Wednesday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.wed2, cell: routineCell, color: UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0))
            case "Thursday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.thu2, cell: routineCell, color: UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0))
            case "Friday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.fri2, cell: routineCell, color: UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0))
            case "Saturday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.sat2, cell: routineCell, color: UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0))
            case "Sunday":
                configureRoutineStep(index: indexPath.row, currentDay: GlobalDataManager.sharedGlobalManager.sun2, cell: routineCell, color: UIColor(red: 68/255, green: 192/255, blue: 207/255, alpha: 1.0))
            default:
                break
            }
        }
        
        return routineCell
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
    // Cell düzenleme
    func configureRoutineStep(index: Int, currentDay: Array<String>, cell: UITableViewCell, color: UIColor) {
        if index < currentDay.count {
            if let dayItem = Int(currentDay[index]) {
                if let dayProduct = GlobalDataManager.sharedGlobalManager.productListName?[dayItem] {
                    let stepNumber = "\(index + 1). Step:"
                    let stepText = "\(stepNumber) \(String(describing: dayProduct))"
                    
                    let attributedString = NSMutableAttributedString(string: stepText)
                    
                    let stepRange = NSRange(location: 0, length: stepNumber.count)
                    let productRange = NSRange(location: stepNumber.count + 1, length: dayProduct.count)
                    
                    attributedString.addAttribute(.foregroundColor, value: color, range: stepRange)
                    attributedString.addAttribute(.foregroundColor, value: UIColor(red: 55/255, green: 41/255, blue: 77/255, alpha: 1.0), range: productRange)
                    
                    let stepFont = UIFont(name: "Bodoni 72 Bold", size: 20)!
                    let productFont = UIFont(name: "Bodoni 72 Book", size: 17)!
                    
                    attributedString.addAttribute(.font, value: stepFont, range: stepRange)
                    attributedString.addAttribute(.font, value: productFont, range: productRange)
                    
                    cell.textLabel?.attributedText = attributedString
                }
            }
        }
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

extension UIApplication {
    class func restartApplication() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let windowDelegate = windowScene.delegate as? SceneDelegate {
                windowDelegate.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            }
        }
    }
}
