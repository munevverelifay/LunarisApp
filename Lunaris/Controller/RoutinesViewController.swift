//
//  RoutinesViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 25.04.2023.
//

import UIKit

class RoutinesViewController: UIViewController {
    @IBOutlet weak var routinePageTitleCollectionView: UICollectionView!
    @IBOutlet weak var allRoutinesView: UIView!
    @IBOutlet weak var activatedRoutinesView: UIView!
    @IBOutlet weak var addStepButton: UIButton!
    @IBOutlet weak var stepCollectionView: UICollectionView!
    @IBOutlet weak var morningRoutineView: UIView!
    @IBOutlet weak var morningRoutineLabel: UILabel!
    @IBOutlet weak var eveningRoutineLabel: UILabel!
    @IBOutlet weak var eveningRoutineView: UIView!
    
    var steps: [String] = [] { // Adımları tutan dizi
        didSet {
            //test = Array(repeating: [], count: steps.count)
            if indexSelect != nil {
                if addControl {
                    checkTest.append(days)
                    test = checkTest
                } else {
                    test = checkTest
                }
                print("Yeni ekleme test \(test)")
                print("Yeni ekleme checktest \(checkTest)")
            } else {
                test.removeAll(keepingCapacity: false)
                for (index, _) in steps.enumerated() {
                // Days dizisine elemanları ekleyin veya işlem yapın
                    if checkTest.isEmpty {
                        test.append(days)
                    } else if steps.count - 1 == index {
                        test.append(days)
                    }
                }
            }
            print("Yeni ekleme veya eklemem test \(test) ")
            stepCollectionView.reloadData()
        }
    }
    
    var morning: Bool = true
    var addControl: Bool = false
    
    var morningSteps: [String] = []
    var eveningSteps: [String] = []
    
    var test: [[Bool]] = []
    
    var morningTest: [[Bool]] = []
    var eveningTest: [[Bool]] = []
    
    var days: [Bool] = [false, false, false, false, false, false, false]
    
    var indexSelect: Int? {
        didSet {
            checkTest = test
            print(test)
            stepCollectionView.reloadData()
//
//            // Eğer indexSelect değeri geçerliyse (nil değilse) ve test dizisinin boyutu indexSelect için uygunsa devam edin
//            if let index = indexSelect, index < test.count {
//                let selectedDays = test[index]
//
//                // `selectedDays` dizisindeki `true` olan elemanların indekslerini bulun
//                let trueIndices = selectedDays.enumerated().compactMap { $0.element ? $0.offset : nil }
//
//                if let routineStepCell = stepCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? RoutineStepCell {
//                    // RoutineStepCell'e eriştik, monView'a erişebiliriz
//                    for dayIndex in trueIndices {
//                        // İlgili günün rengini değiştirin
//                        switch dayIndex {
//                        case 0:
//                            routineStepCell.monView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
//                            routineStepCell.monLabel.textColor = UIColor.white
//                            routineStepCell.monCheckMarkImageView.tintColor = UIColor.white
//                        case 1:
//                            routineStepCell.tueView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
//                            routineStepCell.tueLabel.textColor = UIColor.white
//                            routineStepCell.tueCheckMarkImageView.tintColor = UIColor.white
//                        case 2:
//                            routineStepCell.wedView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
//                            routineStepCell.wedLabel.textColor = UIColor.white
//                            routineStepCell.wedCheckMarkImageView.tintColor = UIColor.white
//                        default:
//                            break
//                        }
//                    }
//                }
//            }
        }
    }

    
    var checkTest: [[Bool]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routinePageTitleCollectionView.dataSource = self
        routinePageTitleCollectionView.delegate = self
        routinePageTitleCollectionView.register(UINib(nibName: String(describing: PageTitleCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PageTitleCell.self))
        
        stepCollectionView.dataSource = self
        stepCollectionView.delegate = self
        stepCollectionView.register(UINib(nibName: String(describing: RoutineStepCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: RoutineStepCell.self))
        stepCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        routinePageTitleCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        configureRoutinesLabelView(routineBgView: allRoutinesView, routineBgColor: UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0))
        configureRoutinesLabelView(routineBgView: activatedRoutinesView, routineBgColor: UIColor.white)
        
        configureButton(btn: addStepButton)
        
        
        let tapMorningRoutineGesture = UITapGestureRecognizer(target: self, action: #selector(tappedMorningRoutineLabel))
        configureTouchableLabel(label: morningRoutineLabel, gesture: tapMorningRoutineGesture)
        
        let tapEveningRoutineGesture = UITapGestureRecognizer(target: self, action: #selector(tappedEveningRoutineLabel))
        configureTouchableLabel(label: eveningRoutineLabel, gesture: tapEveningRoutineGesture)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func addStepButton(_ sender: UIButton) {
        addControl = true
        steps.append("New Step")
    }

    @objc func deleteButtonTapped(_ sender: UIButton) { //bunun yerine kaydırma ile yap
        addControl = false
        guard let buttonPosition = sender.convert(CGPoint.zero, to: stepCollectionView) as CGPoint?,
               let indexPath = stepCollectionView.indexPathForItem(at: buttonPosition) else {
             return // Silinecek adımın indeksi bulunamadı
         }
        stepCollectionView.performBatchUpdates({
            steps.remove(at: indexPath.item) // Tıklanan adımı diziden sil
            stepCollectionView.deleteItems(at: [indexPath])
        }, completion: nil)
        let indexPaths = stepCollectionView.indexPathsForVisibleItems
        stepCollectionView.reloadItems(at: indexPaths)
        
        test.remove(at: indexPath.item)
        if (indexSelect != nil) {
            checkTest.remove(at: indexPath.item)
            test = checkTest
            print("Test \(test)")
            print("Check \(checkTest)")
        }
    }
    
    @objc func editStepNameImageViewTapped(_ sender: UIImageView) { //bunun yerine kaydırma ile yap
        if let selectStepVC = storyboard?.instantiateViewController(withIdentifier: "SelectStepViewController") as? SelectStepViewController {
            self.navigationController?.pushViewController(selectStepVC, animated: true)
            navigationController?.isNavigationBarHidden = false
        }

    }
    
    @objc func editProductImageViewTapped(_ sender: UIImageView) { //bunun yerine kaydırma ile yap
        if let selectStepVC = storyboard?.instantiateViewController(withIdentifier: "StepProductViewController") as? StepProductViewController {
            self.navigationController?.pushViewController(selectStepVC, animated: true)
            navigationController?.isNavigationBarHidden = false
        }

    }
    
    @objc func tappedMorningRoutineLabel() {
        addControl = false
        if morning {
            morning = true
        } else {
            eveningSteps = steps
            steps = []
            steps = morningSteps
            morning = true
            morningRoutineView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            morningRoutineLabel.textColor = UIColor.white
            eveningRoutineView.backgroundColor = UIColor.white
            eveningRoutineLabel.textColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
        }
     
    }
    
    @objc func tappedEveningRoutineLabel() {
        addControl = false
        if morning {
            morningSteps = steps
            steps = []
            steps = eveningSteps
            morning = false
            eveningRoutineView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            eveningRoutineLabel.textColor = UIColor.white
            morningRoutineView.backgroundColor = UIColor.white
            morningRoutineLabel.textColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)

        } else {
           morning = false
        }
    }
    
    @objc func monViewTapped(_ sender: UITapGestureRecognizer) {
        let viewPosition = sender.location(in: stepCollectionView)
        if let indexPath = stepCollectionView.indexPathForItem(at: viewPosition) {
            // Silinecek adımın indeksi bulundu, indexPath'i kullanabilirsiniz
            let item = indexPath.item
            // Diğer işlemleri burada gerçekleştiri
            test[item][0] = true
            indexSelect = item
        
            
            stepCollectionView.reloadData()
        } else {
            // Silinecek adımın indeksi bulunamadı
            return
        }
    }

    @objc func tueViewTapped(_ sender: UITapGestureRecognizer) {
        let viewPosition = sender.location(in: stepCollectionView)
        if let indexPath = stepCollectionView.indexPathForItem(at: viewPosition) {
            // Silinecek adımın indeksi bulundu, indexPath'i kullanabilirsiniz
            let item = indexPath.item
            // Diğer işlemleri burada gerçekleştiri
            test[item][1] = true
            indexSelect = item
        } else {
            // Silinecek adımın indeksi bulunamadı
            return
        }
    }
    @objc func wedViewTapped(_ sender: UITapGestureRecognizer) {
        let viewPosition = sender.location(in: stepCollectionView)
        if let indexPath = stepCollectionView.indexPathForItem(at: viewPosition) {
            // Silinecek adımın indeksi bulundu, indexPath'i kullanabilirsiniz
            let item = indexPath.item
            // Diğer işlemleri burada gerçekleştiri
            test[item][2] = true
            indexSelect = item
        } else {
            // Silinecek adımın indeksi bulunamadı
            return
        }
    }
    @objc func thuViewTapped(_ sender: UITapGestureRecognizer) {
        let viewPosition = sender.location(in: stepCollectionView)
        if let indexPath = stepCollectionView.indexPathForItem(at: viewPosition) {
            // Silinecek adımın indeksi bulundu, indexPath'i kullanabilirsiniz
            let item = indexPath.item
            // Diğer işlemleri burada gerçekleştiri
            test[item][3] = true
            indexSelect = item
        } else {
            // Silinecek adımın indeksi bulunamadı
            return
        }
    }
    @objc func friViewTapped(_ sender: UITapGestureRecognizer) {
        let viewPosition = sender.location(in: stepCollectionView)
        if let indexPath = stepCollectionView.indexPathForItem(at: viewPosition) {
            // Silinecek adımın indeksi bulundu, indexPath'i kullanabilirsiniz
            let item = indexPath.item
            // Diğer işlemleri burada gerçekleştiri
            test[item][4] = true
            indexSelect = item
        } else {
            // Silinecek adımın indeksi bulunamadı
            return
        }
    }
    @objc func satViewTapped(_ sender: UITapGestureRecognizer) {
        let viewPosition = sender.location(in: stepCollectionView)
        if let indexPath = stepCollectionView.indexPathForItem(at: viewPosition) {
            // Silinecek adımın indeksi bulundu, indexPath'i kullanabilirsiniz
            let item = indexPath.item
            // Diğer işlemleri burada gerçekleştiri
            test[item][5] = true
            indexSelect = item
        } else {
            // Silinecek adımın indeksi bulunamadı
            return
        }
    }
    @objc func sunViewTapped(_ sender: UITapGestureRecognizer) {
        let viewPosition = sender.location(in: stepCollectionView)
        if let indexPath = stepCollectionView.indexPathForItem(at: viewPosition) {
            // Silinecek adımın indeksi bulundu, indexPath'i kullanabilirsiniz
            let item = indexPath.item
            // Diğer işlemleri burada gerçekleştiri
            test[item][6] = true
            indexSelect = item
        } else {
            // Silinecek adımın indeksi bulunamadı
            return
        }
    }
    
    
}
extension RoutinesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == routinePageTitleCollectionView {
            return 2
        } else {
            return steps.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == routinePageTitleCollectionView {
            guard let pageTitleCell = routinePageTitleCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PageTitleCell.self), for: indexPath) as? PageTitleCell else {
                return UICollectionViewCell()
            }
            
            if indexPath.item == 0 {
                pageTitleCell.pageTitleLabel.text = "Daily"
                
            } else if indexPath.item == 1 {
                pageTitleCell.pageTitleLabel.text = "Routines"
                
            }
            
            return pageTitleCell
            
        } else {

            guard let routineStepCell = stepCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RoutineStepCell.self), for: indexPath) as? RoutineStepCell else {
                return UICollectionViewCell()
            }
            routineStepCell.deleteStepButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside) // butona silme aksiyonu eklenir
            routineStepCell.deleteStepButton.tag = indexPath.row // silinecek hücrenin index değeri butonun tag özelliğine atanır
            
            let step = routineStepCell.deleteStepButton.tag + 1
             routineStepCell.stepNumberLabel.text = String(step) + "."
        
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editStepNameImageViewTapped(_:)))
            routineStepCell.editStepNameImage.isUserInteractionEnabled = true
            routineStepCell.editStepNameImage.addGestureRecognizer(tapGesture)

            let productTapGesture = UITapGestureRecognizer(target: self, action: #selector(editProductImageViewTapped(_:)))
            routineStepCell.addStepProductImageView.isUserInteractionEnabled = true
            routineStepCell.addStepProductImageView.addGestureRecognizer(productTapGesture)
            
            let monTapGesture = UITapGestureRecognizer(target: self, action: #selector(monViewTapped(_:)))
            routineStepCell.monView.isUserInteractionEnabled = true
            routineStepCell.monView.addGestureRecognizer(monTapGesture)

            let tueTapGesture = UITapGestureRecognizer(target: self, action: #selector(tueViewTapped(_:)))
            routineStepCell.tueView.isUserInteractionEnabled = true
            routineStepCell.tueView.addGestureRecognizer(tueTapGesture)
            
            let wedTapGesture = UITapGestureRecognizer(target: self, action: #selector(wedViewTapped(_:)))
            routineStepCell.wedView.isUserInteractionEnabled = true
            routineStepCell.wedView.addGestureRecognizer(wedTapGesture)
            
            let thuTapGesture = UITapGestureRecognizer(target: self, action: #selector(thuViewTapped(_:)))
            routineStepCell.thuView.isUserInteractionEnabled = true
            routineStepCell.thuView.addGestureRecognizer(thuTapGesture)
            
            let friTapGesture = UITapGestureRecognizer(target: self, action: #selector(friViewTapped(_:)))
            routineStepCell.friView.isUserInteractionEnabled = true
            routineStepCell.friView.addGestureRecognizer(friTapGesture)
            
            let satTapGesture = UITapGestureRecognizer(target: self, action: #selector(satViewTapped(_:)))
            routineStepCell.satView.isUserInteractionEnabled = true
            routineStepCell.satView.addGestureRecognizer(satTapGesture)
            
            let sunTapGesture = UITapGestureRecognizer(target: self, action: #selector(sunViewTapped(_:)))
            routineStepCell.sunView.isUserInteractionEnabled = true
            routineStepCell.sunView.addGestureRecognizer(sunTapGesture)

            
            let viewArr = [routineStepCell.monView, routineStepCell.tueView, routineStepCell.wedView, routineStepCell.thuView, routineStepCell.friView, routineStepCell.satView, routineStepCell.sunView]
            
            let lblArr = [routineStepCell.monLabel, routineStepCell.tueLabel, routineStepCell.wedLabel, routineStepCell.thuLabel, routineStepCell.friLabel, routineStepCell.satLabel, routineStepCell.sunLabel]
            
            viewArr.forEach { item in
                item?.backgroundColor = UIColor.white
            }
            
            lblArr.forEach { item in
                item?.textColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
            }

            let selectedArr = test[indexPath.item]
            let trueIndices = selectedArr.enumerated().compactMap { $0.element ? $0.offset : nil }
            for dayIndex in trueIndices {
                // İlgili günün rengini değiştirin
                switch dayIndex {
                case 0:
                    routineStepCell.monView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                    routineStepCell.monLabel.textColor = UIColor.white
                    routineStepCell.monCheckMarkImageView.tintColor = UIColor.white
                case 1:
                    routineStepCell.tueView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                    routineStepCell.tueLabel.textColor = UIColor.white
                    routineStepCell.tueCheckMarkImageView.tintColor = UIColor.white
                case 2:
                    routineStepCell.wedView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                    routineStepCell.wedLabel.textColor = UIColor.white
                    routineStepCell.wedCheckMarkImageView.tintColor = UIColor.white
                default:
                    break
                }
            }
            return routineStepCell
        }
        
    }
    


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == routinePageTitleCollectionView {
            if indexPath.item == 0 {
                if let dailyRoutineVC = storyboard?.instantiateViewController(withIdentifier: "DailyRoutineViewController") as? DailyRoutineViewController {

                    self.navigationController?.pushViewController(dailyRoutineVC, animated: false)
                    navigationController?.isNavigationBarHidden = true
                }
            }
        } else {
            GlobalDataManager.sharedGlobalManager.currentStep = indexPath.item
            stepCollectionView.reloadData()
        }
    }
    
    

}
extension RoutinesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == routinePageTitleCollectionView {
            return CGSize(width: 90, height: 30)
        } else {
            return CGSize(width: 410, height: 161)
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == routinePageTitleCollectionView {
            return 0
        } else {
            return 20
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == routinePageTitleCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 2, bottom: 20, right: 2)
        }
    }
}
