//
//  DailyRoutineViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 4.06.2023.
//

import UIKit
import Kingfisher

class DailyRoutineViewController: UIViewController {
    @IBOutlet weak var dailyRoutineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyRoutineTableView.dataSource = self
        dailyRoutineTableView.delegate = self
        dailyRoutineTableView.layer.cornerRadius = 20
        dailyRoutineTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DailyyRoutineCell")
        dailyRoutineTableView.register(UINib(nibName: "DayRoutineCell", bundle: nil), forCellReuseIdentifier: "DayRoutineCell")

        dailyRoutineTableView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        title = "Daily Routine"
        configureNavigationTitle()
        configureRoutineData()
        
        let newRoutineButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newRoutineButtonTapped))

        // Düğmeyi navigationItem'a ata
        navigationItem.rightBarButtonItem = newRoutineButton
        
        dailyRoutineTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureRoutineData()
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
                
                self.dailyRoutineTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func newRoutineButtonTapped() {
        if let sendCodeVC = storyboard?.instantiateViewController(withIdentifier: "RoutinesViewController") as? RoutinesViewController {
            self.navigationController?.pushViewController(sendCodeVC, animated: true)
        }
    }

}

extension DailyRoutineViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return GlobalDataManager.sharedGlobalManager.mon1.count + GlobalDataManager.sharedGlobalManager.mon2.count
        } else if section == 1 {
            return GlobalDataManager.sharedGlobalManager.tue1.count + GlobalDataManager.sharedGlobalManager.tue2.count
        } else if section == 2 {
            return GlobalDataManager.sharedGlobalManager.wed1.count + GlobalDataManager.sharedGlobalManager.wed2.count
        } else if section == 3 {
            return GlobalDataManager.sharedGlobalManager.thu1.count + GlobalDataManager.sharedGlobalManager.thu2.count
        } else if section == 4 {
            return GlobalDataManager.sharedGlobalManager.fri1.count + GlobalDataManager.sharedGlobalManager.fri2.count
        } else if section == 5 {
            return GlobalDataManager.sharedGlobalManager.sat1.count + GlobalDataManager.sharedGlobalManager.sat2.count
        } else {
            return GlobalDataManager.sharedGlobalManager.sun1.count + GlobalDataManager.sharedGlobalManager.sun2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dayRoutineCell = tableView.dequeueReusableCell(withIdentifier: "DayRoutineCell", for: indexPath) as? DayRoutineCell else { return UITableViewCell() }
        dayRoutineCell.backgroundColor = .clear
        dayRoutineCell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)

        var productList: [String] = []
           
           switch indexPath.section {
           case 0:
               productList = GlobalDataManager.sharedGlobalManager.mon1 + GlobalDataManager.sharedGlobalManager.mon2
           case 1:
               productList = GlobalDataManager.sharedGlobalManager.tue1 + GlobalDataManager.sharedGlobalManager.tue2
           case 2:
               productList = GlobalDataManager.sharedGlobalManager.wed1 + GlobalDataManager.sharedGlobalManager.wed2
           case 3:
               productList = GlobalDataManager.sharedGlobalManager.thu1 + GlobalDataManager.sharedGlobalManager.thu2
           case 4:
               productList = GlobalDataManager.sharedGlobalManager.fri1 + GlobalDataManager.sharedGlobalManager.fri2
           case 5:
               productList = GlobalDataManager.sharedGlobalManager.sat1 + GlobalDataManager.sharedGlobalManager.sat2
           case 6:
               productList = GlobalDataManager.sharedGlobalManager.sun1 + GlobalDataManager.sharedGlobalManager.sun2
           default:
               break
           }
        
        let productListInt = productList.compactMap { Int($0) }
        print(productListInt)
        
        if indexPath.row < productList.count {
            let item = productListInt[indexPath.row]
            dayRoutineCell.productNameLabel.text = GlobalDataManager.sharedGlobalManager.productListName?[item]
            dayRoutineCell.productCategoryLabel.text = GlobalDataManager.sharedGlobalManager.productListCategories?[item]
            if let imageUrlString = GlobalDataManager.sharedGlobalManager.productListImage?[item],
               let imageUrl = URL(string: imageUrlString) {
                dayRoutineCell.productImageView.kf.setImage(with: imageUrl)
            }
            
        } else {
            dayRoutineCell.productNameLabel.text =  "Product Name"
            dayRoutineCell.productCategoryLabel.text = "Product Category"
            
            let defaultImageUrlString = "cerave"
            let defaultImageUrl = URL(string: defaultImageUrlString)
            dayRoutineCell.productImageView.kf.setImage(with: defaultImageUrl)
            
        }
        
        return dayRoutineCell
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        let dayColor = UIColor(red: 249/255, green: 36/255, blue: 87/255, alpha: 1.0)
        let font = UIFont(name: "Bodoni 72 Bold", size: 23)
        
        titleLabel.font = font
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        if section == 0 {
            titleLabel.text = "Monday"
            titleLabel.textColor = dayColor
        } else if section == 1 {
            titleLabel.text = "Tuesday"
            titleLabel.textColor = dayColor
        } else if section == 2 {
            titleLabel.text = "Wednesday"
            titleLabel.textColor = dayColor
        } else if section == 3 {
            titleLabel.text = "Thursday"
            titleLabel.textColor = dayColor
        } else if section == 4 {
            titleLabel.text = "Friday"
            titleLabel.textColor = dayColor
        } else if section == 5 {
            titleLabel.text = "Saturday"
            titleLabel.textColor = dayColor
        } else {
            titleLabel.text = "Sunday"
            titleLabel.textColor = dayColor
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65
    }

}


