//
//  DailyRoutineViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 4.06.2023.
//

import UIKit

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
        
    }
}

extension DailyRoutineViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        } else if section == 5 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dayRoutineCell = tableView.dequeueReusableCell(withIdentifier: "DayRoutineCell", for: indexPath) as? DayRoutineCell else { return UITableViewCell() }
        dayRoutineCell.backgroundColor = .clear
        dayRoutineCell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
           
        // Hücreyi doldurmak için gerekli işlemleri yapabilirsiniz
        // Örneğin, labelların metinlerini atayabilirsiniz: dailyRoutineCell.label1.text = "Birinci Label Metni"
        
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


