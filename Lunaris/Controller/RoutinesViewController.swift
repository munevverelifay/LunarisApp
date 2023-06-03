//
//  RoutinesViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 25.04.2023.
//

import UIKit

class RoutinesViewController: UIViewController {
    @IBOutlet weak var allRoutinesView: UIView!
    @IBOutlet weak var activatedRoutinesView: UIView!
    @IBOutlet weak var addStepButton: UIButton!
    @IBOutlet weak var stepCollectionView: UICollectionView!
    @IBOutlet weak var morningRoutineView: UIView!
    @IBOutlet weak var morningRoutineLabel: UILabel!
    @IBOutlet weak var eveningRoutineLabel: UILabel!
    @IBOutlet weak var eveningRoutineView: UIView!
    
    var morningRoutine: String = ""
    var eveningRoutine: String = ""
    
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
        }
    }

    
    var checkTest: [[Bool]] = []
    var checkMorTest: [[Bool]] = []
    var checkEveTest: [[Bool]] = []
    
    var productIdArray: [String] = [] {
        didSet {
            print("productların idsi")
            print(productIdArray)
        }
    }
    
    var productImageArray: [String] = []
    var morningProductImageArray: [String] = []
    var eveningProductImageArray: [String] = []
    
    var morningProductIdArray: [String] = []
    var eveningProductIdArray: [String] = []
    
    var productNameArray: [String] = []
    var morningProductNameArray: [String] = []
    var eveningProductNameArray: [String] = []
    
    var productBrandNameArray: [String] = []
    var morningProductBrandArray: [String] = []
    var eveningProductBrandArray: [String] = []
    
    var selectedProductCell: [Int] = [] {
        didSet {
            stepCollectionView.reloadData()
        }
    }
    var morningSelectedProductCell: [Int] = []
    var eveningSelectedProductCell: [Int] = []
    
    
    //MARK: - Morning Day Save Array
    var morMonArray: [Int] = []
    var morTueArray: [Int] = []
    var morWedArray: [Int] = []
    var morThuArray: [Int] = []
    var morFriArray: [Int] = []
    var morSatArray: [Int] = []
    var morSunArray: [Int] = []
    
    //MARK: - Evening Day Save Array
    var eveMonArray: [Int] = []
    var eveTueArray: [Int] = []
    var eveWedArray: [Int] = []
    var eveThuArray: [Int] = []
    var eveFriArray: [Int] = []
    var eveSatArray: [Int] = []
    var eveSunArray: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Routines"
        configureNavigationTitle()
        
        stepCollectionView.dataSource = self
        stepCollectionView.delegate = self
        stepCollectionView.register(UINib(nibName: String(describing: RoutineStepCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: RoutineStepCell.self))
        stepCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        
        configureRoutinesLabelView(routineBgView: allRoutinesView, routineBgColor: UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0))
        configureRoutinesLabelView(routineBgView: activatedRoutinesView, routineBgColor: UIColor.white)
        
        configureButton(btn: addStepButton)
        
        
        let tapMorningRoutineGesture = UITapGestureRecognizer(target: self, action: #selector(tappedMorningRoutineLabel))
        configureTouchableLabel(label: morningRoutineLabel, gesture: tapMorningRoutineGesture)
        
        let tapEveningRoutineGesture = UITapGestureRecognizer(target: self, action: #selector(tappedEveningRoutineLabel))
        configureTouchableLabel(label: eveningRoutineLabel, gesture: tapEveningRoutineGesture)

        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedProduct(_:)), name: Notification.Name("SelectedProduct"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if morning {
            if morningTest.isEmpty {
                morningTest = checkTest
                morningProductIdArray = productIdArray
            } else {
                morningTest = checkTest
                morningProductIdArray = productIdArray
            }
        } else {
            if eveningTest.isEmpty {
                eveningTest = checkTest
                eveningProductIdArray = productIdArray
            } else {
                eveningTest = checkTest
                eveningProductIdArray = productIdArray
            }
        }
        //MARK: - Morning Product set save data
        morMonArray = []
        morTueArray = []
        morWedArray = []
        morThuArray = []
        morFriArray = []
        morSatArray = []
        morSunArray = []
        
        var daysIndexControl = 0
        
        morningTest.forEach { days in
            var itemIndexControl = 0
            days.forEach { item in
                if item == true {
                    switch itemIndexControl {
                    case 0:
                        morMonArray.append(daysIndexControl)
                    case 1:
                        morTueArray.append(daysIndexControl)
                    case 2:
                        morWedArray.append(daysIndexControl)
                    case 3:
                        morThuArray.append(daysIndexControl)
                    case 4:
                        morFriArray.append(daysIndexControl)
                    case 5:
                        morSatArray.append(daysIndexControl)
                    case 6:
                        morSunArray.append(daysIndexControl)
                    default:
                        break
                    }
                }
                itemIndexControl += 1
            }
            daysIndexControl += 1
        }
        
        var morMonIDArray : [String] = []
        var morTueIDArray : [String] = []
        var morWedIDArray : [String] = []
        var morThuIDArray : [String] = []
        var morFriIDArray : [String] = []
        var morSatIDArray : [String] = []
        var morSunIDArray : [String] = []
       
        var controlll = 0
        selectedProductCell.forEach { item in
            morMonArray.forEach { mon in
                if item == mon {
                    let string = String(describing: morningProductIdArray[controlll])
                    morMonIDArray.append(string)
                }
            }
            morTueArray.forEach { tue in
                if item == tue {
                    let string = String(describing: morningProductIdArray[controlll])
                    morTueIDArray.append(string)
                }
            }
            
            morWedArray.forEach { tue in
                if item == tue {
                    let string = String(describing: morningProductIdArray[controlll])
                    morWedIDArray.append(string)
                }
            }
            
            morThuArray.forEach { tue in
                if item == tue {
                    let string = String(describing: morningProductIdArray[controlll])
                    morThuIDArray.append(string)
                }
            }
            
            morFriArray.forEach { tue in
                if item == tue {
                    let string = String(describing: morningProductIdArray[controlll])
                    morFriIDArray.append(string)
                }
            }
            
            morSatArray.forEach { tue in
                if item == tue {
                    let string = String(describing: morningProductIdArray[controlll])
                    morSatIDArray.append(string)
                }
            }
            
            morSunArray.forEach { tue in
                if item == tue {
                    let string = String(describing: morningProductIdArray[controlll])
                    morSunIDArray.append(string)
                }
            }
            controlll += 1
        }
        
        let morMonString = morMonIDArray.joined(separator: ",")
        let morTueString = morTueIDArray.joined(separator: ",")
        let morWedString = morWedIDArray.joined(separator: ",")
        let morThuString = morThuIDArray.joined(separator: ",")
        let morFriString = morFriIDArray.joined(separator: ",")
        let morSatString = morSatIDArray.joined(separator: ",")
        let morSunString = morSunIDArray.joined(separator: ",")


        morningRoutine = "mon=\(morMonString)&tue=\(morTueString)&wed=\(morWedString)&thu=\(morThuString)&fri=\(morFriString)&sat=\(morSatString)&sun=\(morSunString)&time=0"
    
        //MARK: - Evening Product set save data

        eveMonArray = []
        eveTueArray = []
        eveWedArray = []
        eveThuArray = []
        eveFriArray = []
        eveSatArray = []
        eveSunArray = []

        var eveDaysIndexControl = 0

        eveningTest.forEach { days in
            var eveItemIndexControl = 0
            days.forEach { item in
                if item == true {
                    switch eveItemIndexControl {
                    case 0:
                        eveMonArray.append(eveDaysIndexControl)
                    case 1:
                        eveTueArray.append(eveDaysIndexControl)
                    case 2:
                        eveWedArray.append(eveDaysIndexControl)
                    case 3:
                        eveThuArray.append(eveDaysIndexControl)
                    case 4:
                        eveFriArray.append(eveDaysIndexControl)
                    case 5:
                        eveSatArray.append(eveDaysIndexControl)
                    case 6:
                        eveSunArray.append(eveDaysIndexControl)
                    default:
                        break
                    }
                }
                eveItemIndexControl += 1
            }
            eveDaysIndexControl += 1
        }

        var eveMonIDArray: [String] = []
        var eveTueIDArray: [String] = []
        var eveWedIDArray: [String] = []
        var eveThuIDArray: [String] = []
        var eveFriIDArray: [String] = []
        var eveSatIDArray: [String] = []
        var eveSunIDArray: [String] = []

        var eveningDaysControl = 0
        selectedProductCell.forEach { item in
            eveMonArray.forEach { mon in
                if item == mon {
                    let string = String(describing: eveningProductIdArray[eveningDaysControl])
                    eveMonIDArray.append(string)
                }
            }
            eveTueArray.forEach { tue in
                if item == tue {
                    let string = String(describing: eveningProductIdArray[eveningDaysControl])
                    eveTueIDArray.append(string)
                }
            }

            eveWedArray.forEach { tue in
                if item == tue {
                    let string = String(describing: eveningProductIdArray[eveningDaysControl])
                    eveWedIDArray.append(string)
                }
            }

            eveThuArray.forEach { tue in
                if item == tue {
                    let string = String(describing: eveningProductIdArray[eveningDaysControl])
                    eveThuIDArray.append(string)
                }
            }

            eveFriArray.forEach { tue in
                if item == tue {
                    let string = String(describing: eveningProductIdArray[eveningDaysControl])
                    eveFriIDArray.append(string)
                }
            }

            eveSatArray.forEach { tue in
                if item == tue {
                    let string = String(describing: eveningProductIdArray[eveningDaysControl])
                    eveSatIDArray.append(string)
                }
            }

            eveSunArray.forEach { tue in
                if item == tue {
                    let string = String(describing: eveningProductIdArray[eveningDaysControl])
                    eveSunIDArray.append(string)
                }
            }
            eveningDaysControl += 1
        }

        let eveMonString = eveMonIDArray.joined(separator: ",")
        let eveTueString = eveTueIDArray.joined(separator: ",")
        let eveWedString = eveWedIDArray.joined(separator: ",")
        let eveThuString = eveThuIDArray.joined(separator: ",")
        let eveFriString = eveFriIDArray.joined(separator: ",")
        let eveSatString = eveSatIDArray.joined(separator: ",")
        let eveSunString = eveSunIDArray.joined(separator: ",")

        eveningRoutine = "mon=\(eveMonString)&tue=\(eveTueString)&wed=\(eveWedString)&thu=\(eveThuString)&fri=\(eveFriString)&sat=\(eveSatString)&sun=\(eveSunString)&time=1"

        configureRoutineData(routineEve: eveningRoutine, routineMor: morningRoutine)
    }
    
    func configureRoutineData(routineEve: String, routineMor: String ) {
        NetworkService.sharedNetwork.postRoutine(userId: GlobalDataManager.sharedGlobalManager.userId, routine: routineMor) { response in
            switch response {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
                    print(result)
                    if result == "true" {
                        print("fuck")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        NetworkService.sharedNetwork.postRoutine(userId: GlobalDataManager.sharedGlobalManager.userId, routine: routineEve) { response in
            switch response {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
                    print(result)
                    if result == "true" {
                        print("fuck")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func addStepButton(_ sender: UIButton) {
        addControl = true
        steps.append("New Step")
        print("testtttt")
        print(test)
        print("morninnggg")
        print(morningTest)
        print("eveningggg")
        print(eveningTest)
    }

    @objc func deleteButtonTapped(_ sender: UIButton) { //bunun yerine kaydırma ile yap
        addControl = false
        guard let buttonPosition = sender.convert(CGPoint.zero, to: stepCollectionView) as CGPoint?,
               let indexPath = stepCollectionView.indexPathForItem(at: buttonPosition) else {
             return // Silinecek adımın indeksi bulunamadı
         }
        
        test.remove(at: indexPath.item)
        if (indexSelect != nil) {
            checkTest.remove(at: indexPath.item)
            test = checkTest
            print("Test \(test)")
            print("Check \(checkTest)")
        }

        
        stepCollectionView.performBatchUpdates({
            steps.remove(at: indexPath.item) // Tıklanan adımı diziden sil
            stepCollectionView.deleteItems(at: [indexPath])
        }, completion: nil)
        let indexPaths = stepCollectionView.indexPathsForVisibleItems
        
        selectedProductCell.forEach { item in
            if item == indexPath.item {
                if let index = selectedProductCell.firstIndex(of: item) {
                    selectedProductCell.remove(at: index)
                    productNameArray.remove(at: index)
                    productBrandNameArray.remove(at: index)
                    productIdArray.remove(at: index)
                    productImageArray.remove(at: index)
                }
            } else if item > indexPath.item {
                if let index = selectedProductCell.firstIndex(of: item) {
                    selectedProductCell[index] = selectedProductCell[index] - 1
                }
            }
        }
        stepCollectionView.reloadItems(at: indexPaths)
        stepCollectionView.reloadData()

    }
    
    
    @objc func editProductImageViewTapped(_ sender: UITapGestureRecognizer) { //bunun yerine kaydırma ile yap
        // Dokunulan noktayı alın
        let location = sender.location(in: stepCollectionView)
        
        // Dokunulan noktanın indexPath değerini alın
        if let indexPath = stepCollectionView.indexPathForItem(at: location) {
            // indexPath'i kullanabilirsiniz
            let item = indexPath.item
            
            if selectedProductCell.contains(item) {
                return
            }

            if let selectStepVC = storyboard?.instantiateViewController(withIdentifier: "StepProductViewController") as? StepProductViewController {
                self.navigationController?.pushViewController(selectStepVC, animated: true)
                navigationController?.isNavigationBarHidden = false
                selectStepVC.selectProduct = item
            }
        }
    }
    
    @objc func handleSelectedProduct(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let productName = userInfo["productName"] as? String,
           let productBrand = userInfo["productBrand"] as? String,
           let productIndex = userInfo["productIndex"] as? Int,
           let productId = userInfo["productId"] as? String,
           let productImage = userInfo["productImage"] as? String {
            productNameArray.append(productName)
            productBrandNameArray.append(productBrand)
            selectedProductCell.append(productIndex)
            productIdArray.append(productId)
            productImageArray.append(productImage)
        }
    }

    
    @objc func tappedMorningRoutineLabel() {
        addControl = false
        if morning {
            morning = true
        } else {
            eveningSteps = steps
            eveningTest = test
            checkEveTest = checkTest
            eveningSelectedProductCell = selectedProductCell
            eveningProductNameArray = productNameArray
            eveningProductBrandArray = productBrandNameArray
            eveningProductIdArray = productIdArray
            eveningProductImageArray = productImageArray
            steps = []
            test = []
            checkTest = []
            selectedProductCell = []
            productNameArray = []
            productBrandNameArray = []
            productIdArray = []
            productImageArray = []
            steps = morningSteps
            test = morningTest
            checkTest = checkMorTest
            selectedProductCell = morningSelectedProductCell
            productNameArray = morningProductNameArray
            productBrandNameArray = morningProductBrandArray
            productIdArray = morningProductIdArray
            productImageArray = morningProductImageArray
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
            morningTest = test
            checkMorTest = checkTest
            morningSelectedProductCell = selectedProductCell
            morningProductNameArray = productNameArray
            morningProductBrandArray = productBrandNameArray
            morningProductIdArray = productIdArray
            morningProductImageArray = productImageArray
            steps = []
            test = []
            checkTest = []
            selectedProductCell = []
            productNameArray = []
            productBrandNameArray = []
            productIdArray = []
            productImageArray = []
            steps = eveningSteps
            test = eveningTest
            checkTest = checkEveTest
            selectedProductCell = eveningSelectedProductCell
            productNameArray = eveningProductNameArray
            productBrandNameArray = eveningProductBrandArray
            productIdArray = eveningProductIdArray
            productImageArray = eveningProductImageArray
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
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let routineStepCell = stepCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RoutineStepCell.self), for: indexPath) as? RoutineStepCell else {
            return UICollectionViewCell()
        }
        routineStepCell.deleteStepButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside) // butona silme aksiyonu eklenir
        routineStepCell.deleteStepButton.tag = indexPath.row // silinecek hücrenin index değeri butonun tag özelliğine atanır
        
        let step = routineStepCell.deleteStepButton.tag + 1
        
        routineStepCell.stepNumberLabel.text = String(step) + "."
        
        
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
            case 1:
                routineStepCell.tueView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                routineStepCell.tueLabel.textColor = UIColor.white
            case 2:
                routineStepCell.wedView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                routineStepCell.wedLabel.textColor = UIColor.white
            case 3:
                routineStepCell.thuView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                routineStepCell.thuLabel.textColor = UIColor.white
            case 4:
                routineStepCell.friView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                routineStepCell.friLabel.textColor = UIColor.white
            case 5:
                routineStepCell.satView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                routineStepCell.satLabel.textColor = UIColor.white
            case 6:
                routineStepCell.sunView.backgroundColor = UIColor(red: 254/255, green: 110/255, blue: 128/255, alpha: 1.0)
                routineStepCell.sunLabel.textColor = UIColor.white
            default:
                break
            }
        }
        
        
        routineStepCell.stepProductNameLabel.text = "Product Name"
        routineStepCell.stepProductBrandLabel.text = "Product Brand"
        
        let defaultImageUrlString = "cerave"
        let defaultImageUrl = URL(string: defaultImageUrlString)
        routineStepCell.stepProductImage.kf.setImage(with: defaultImageUrl)
        
        var check = 0
        selectedProductCell.forEach { item in
            if item == indexPath.item {
                routineStepCell.stepProductNameLabel.text = productNameArray[check]
                routineStepCell.stepProductBrandLabel.text = productBrandNameArray[check]
                let imageUrlString = productImageArray[check]
                let imageUrl = URL(string: imageUrlString)
                routineStepCell.stepProductImage.kf.setImage(with: imageUrl)
            }
            check += 1
        }
        
        return routineStepCell
        
        
    }
    


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GlobalDataManager.sharedGlobalManager.currentStep = indexPath.item
        stepCollectionView.reloadData()
        
    }
    
    

}
extension RoutinesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 410, height: 161)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 20, right: 2)
    }
}
