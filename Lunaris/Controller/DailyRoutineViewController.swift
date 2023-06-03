//
//  routineViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 10.04.2023.
//

import UIKit
import FSCalendar

class DailyRoutineViewController: UIViewController {
    
    var formatter = DateFormatter()
    var calendarHeightConstraint: NSLayoutConstraint?
    var timer: Timer?

    @IBOutlet weak var dailyRoutinePageTitleCollectionView: UICollectionView!
    @IBOutlet weak var weeklyFSCalendarView: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyRoutinePageTitleCollectionView.dataSource = self
        dailyRoutinePageTitleCollectionView.delegate = self
        dailyRoutinePageTitleCollectionView.register(UINib(nibName: String(describing: PageTitleCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PageTitleCell.self))
        dailyRoutinePageTitleCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        
//        weeklyFSCalendarView.delegate = self
//        weeklyFSCalendarView.dataSource = self
//        configureWeeklyCalendar(calendar: weeklyFSCalendarView)
//        applyShadowOnView(weeklyFSCalendarView)
//        weeklyFSCalendarView.layer.cornerRadius = weeklyFSCalendarView.frame.height / 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
  
}

//extension DailyRoutineViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
//    func configureWeeklyCalendar(calendar: FSCalendar?) {
//        if let calendar = calendar {
//            
//            calendarHeightConstraint = weeklyFSCalendarView.heightAnchor.constraint(equalToConstant: 300)
//            calendarHeightConstraint?.isActive = true
//            
//            calendar.scrollDirection = .horizontal
//            calendar.setScope(.week, animated: false)
//    
//            
//            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
//            calendar.addGestureRecognizer(panGesture)
//
//            calendar.locale = Locale(identifier: "en") // BU SATIRI CİHAZ DİLİNE GÖRE YAP
//            
//            // Calendar appearance
//            calendar.appearance.headerMinimumDissolvedAlpha = 0.0
//            calendar.appearance.borderDefaultColor = .clear
//            calendar.appearance.borderSelectionColor = .clear
//            
//
//
//            // Offset'i ayarla ve görüntü ve renk ayarlarını da uygula
////            calendar.appearance.headerTitleOffset = offset
//            calendar.appearance.headerTitleColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
//            calendar.appearance.weekdayTextColor = UIColor(red: 176/255, green: 176/255, blue: 176/255, alpha: 1.0)
//            calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 19.0)
//            calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
//            
//            calendar.appearance.todayColor = .clear
//            calendar.appearance.titleTodayColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
//            
//            calendar.appearance.selectionColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
//
//         
//        }
//    }
//    
//    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: view)
//        if translation.y > 0 {
//            // aşağı hareket - aylık takvime geçiş
//            weeklyFSCalendarView.setScope(.month, animated: true)
//        } else {
//            // yukarı hareket - haftalık takvime geçiş
//            weeklyFSCalendarView.setScope(.week, animated: true)
//        }
//    }
//
//    //MARK: - Delegate Func
//    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        formatter.dateFormat = "dd-MMM-yyyy"
//        print("Date Selected == \(formatter.string(from: date))")
//    }
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        // Aşağıdaki satırı ekleyin:
//        self.calendarHeightConstraint?.constant = bounds.height
//        
//    }
//}
//
//extension UIViewController {
//    func applyShadowOnView(_ view: UIView) {
//        view.layer.shadowRadius = 5
//        view.layer.shadowOffset = .zero
//        view.layer.shadowOpacity = 0.1
//        view.layer.shadowColor =   UIColor(red: 90/255, green: 108/255, blue: 234/255, alpha: 1).cgColor
//        view.layer.masksToBounds = false
//        view.layer.shadowOffset = CGSize(width: 2, height: 1)
//    }
//}

extension DailyRoutineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let pageTitleCell = dailyRoutinePageTitleCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PageTitleCell.self), for: indexPath) as? PageTitleCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.item == 0 {
            pageTitleCell.pageTitleLabel.text = "Daily"
            
        } else if indexPath.item == 1 {
            pageTitleCell.pageTitleLabel.text = "Routines"

        }
        
        return pageTitleCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pageTitleCell = collectionView.cellForItem(at: indexPath) as? PageTitleCell {
//            pageTitleCell.pageTitleLabel.font = UIFont(name: "Bodoni 72 Bold", size: 30.00)
//            pageTitleCell.pageTitleLabel.textColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
        }
        
        if indexPath.item == 1 {
            if let routinesVC = storyboard?.instantiateViewController(withIdentifier: "RoutinesViewController") as? RoutinesViewController {
                self.navigationController?.pushViewController(routinesVC, animated: false)
                navigationController?.isNavigationBarHidden = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let pageTitleCell = collectionView.cellForItem(at: indexPath) as? PageTitleCell {
//            pageTitleCell.pageTitleLabel.font = UIFont(name: "Bodoni 72 Bold", size: 20.00)
//            pageTitleCell.pageTitleLabel.textColor = UIColor(red: 176/255, green: 176/255, blue: 176/255, alpha: 1.0)

        }
        
    }

}

extension DailyRoutineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}






