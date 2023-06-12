//
//  SignInViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.04.2023.
//

import UIKit
import Alamofire
import Lottie

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var slashView: UIView!
    @IBOutlet weak var splashImageView: UIImageView!
    @IBOutlet weak var slashAppName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configureTf(tf: emailTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Email")
        
        configureTf(tf: passwordTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Password")
        passwordTextField.isSecureTextEntry = true
        

        configureButton(btn: loginButton)
        
        let tapSignUpGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSignUpLabel))
        configureTouchableLabel(label: signUpLabel, gesture: tapSignUpGesture)
        
        let tapForgotGesture = UITapGestureRecognizer(target: self, action: #selector(tappedForgotLabel))
        configureTouchableLabel(label: forgotPasswordLabel, gesture: tapForgotGesture)
//
//        setupSplashLabel()
//        setupSplashAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        configureFavoriteData()
        configureData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // Check if user is already logged in
         if UserDefaults.standard.bool(forKey: "isLoggedIn") {
             // Retrieve user ID and profile image URL from UserDefaults
             if let userId = UserDefaults.standard.string(forKey: "userID"),
                let userProfileImageURL = UserDefaults.standard.string(forKey: "userProfileImageURL") {
                 // Set the user ID and profile image URL in GlobalDataManager
                 GlobalDataManager.sharedGlobalManager.userId = userId
                 GlobalDataManager.sharedGlobalManager.userImage = userProfileImageURL
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                     // Configure user detail data if needed
                     self.configureUserDetailData {
                         // Present the tab bar controller or any desired screen
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                         let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
                         tabBarController.modalPresentationStyle = .fullScreen
                         self.present(tabBarController, animated: true, completion: nil)
                     }
                 }
             }
         }else {
             UIView.animate(withDuration: 1, animations: {
                 self.slashView.alpha = 0
                 self.splashImageView.alpha = 0
                 self.slashAppName.alpha = 0
             }) { (_) in
                 self.slashView.isHidden = true
                 self.splashImageView.isHidden = true
                 self.slashAppName.isHidden = true
                 self.slashView.alpha = 1
                 self.splashImageView.alpha = 1
                 self.slashAppName.alpha = 1
             }
         }

         
    }

    
    //MARK: - ProductListData
    func configureData() {
        NetworkService.sharedNetwork.getProductList { response in
            switch response{
            case .success(let value):
                print(value[0].id)
                value.forEach { item in
                    let productId = String((Int(item.id) ?? 0) - 1)
                    GlobalDataManager.sharedGlobalManager.productListId?.append(productId)
                    GlobalDataManager.sharedGlobalManager.productListBrand?.append(item.productBrand)
                    GlobalDataManager.sharedGlobalManager.productListName?.append(item.productName)

                    if let productListBrand = GlobalDataManager.sharedGlobalManager.productListBrand,
                       let productListName = GlobalDataManager.sharedGlobalManager.productListName {
                        for index in 0..<productListName.count {
                            if let productBrand = productListBrand[safe: index] {
                                let newProductName = productListName[index].replacingOccurrences(of: productBrand, with: "").trimmingCharacters(in: .whitespaces)
                                GlobalDataManager.sharedGlobalManager.productListName?[index] = newProductName
                            }
                        }
                    }

                    GlobalDataManager.sharedGlobalManager.productListCategories?.append(item.productCategories)
                    GlobalDataManager.sharedGlobalManager.productListIngredients?.append(item.productIndrigients)
                    GlobalDataManager.sharedGlobalManager.productListImage?.append(item.productImage)
                    GlobalDataManager.sharedGlobalManager.productListTotalRating?.append(item.productTotalRating)
                    GlobalDataManager.sharedGlobalManager.productListReviewNumbers?.append(item.productReviewNumbers)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureUserDetailData(completion: @escaping() -> Void) {
        NetworkService.sharedNetwork.getUserDetail(userId: GlobalDataManager.sharedGlobalManager.userId) { response in
            switch response{
            case .success(let value):
                print(value[0])
                GlobalDataManager.sharedGlobalManager.userName = value[0].name
                GlobalDataManager.sharedGlobalManager.userSurname = value[0].surname
                GlobalDataManager.sharedGlobalManager.userDateOfBirth = value[0].dateOfBirth
//               GlobalDataManager.sharedGlobalManager.userDescription = value[0].profileDescription
                GlobalDataManager.sharedGlobalManager.userImage = value[0].userImage
                
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func configureFavoriteData() {
        NetworkService.sharedNetwork.getFavoriteList(userId: GlobalDataManager.sharedGlobalManager.userId) { response in
            switch response {
            case .success(let value):
                print(value)
                value.forEach { item in
                    GlobalDataManager.sharedGlobalManager.favoriteProductsList.append(contentsOf: item.fav)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @objc func tappedSignUpLabel() {
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    @objc func tappedForgotLabel() {
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        NetworkService.sharedNetwork.postUserData(emailTxt: emailTextField.text, passwordTxt: passwordTextField.text) { response in
            switch response {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
                    print(result)
                    if result == "true",
                       let id = json.first?["id"] as? String,
                       let userImg = json.first?["user-img"] as? String {
                        // Save user id and profile image URL to UserDefaults
                        UserDefaults.standard.set(id, forKey: "userID")
                        UserDefaults.standard.set(userImg, forKey: "userProfileImageURL")
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        
                        GlobalDataManager.sharedGlobalManager.userId = id
                        GlobalDataManager.sharedGlobalManager.userImage = userImg
                        
                        
                        // Print user id and profile image URL to console
                        print("User ID: \(id)")
                        print("Profile Image URL: \(userImg)")
                        
                        self.configureUserDetailData {
                            // Present tab bar controller
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let signUpVC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
                            signUpVC.modalPresentationStyle = .fullScreen
                            self.present(signUpVC, animated: true, completion: nil)
                        }
                    }
                } else {
                    print("Invalid response format")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UIViewController {
    func configureTf(tf: UITextField, bgColor: UIColor, placeHolder: String) {
        tf.backgroundColor = bgColor
        tf.layer.cornerRadius = tf.frame.height / 2.5
        tf.borderStyle = .none
        tf.layer.masksToBounds = true
        tf.placeholder = placeHolder
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
    }
    func configureButton(btn: UIButton) {
        btn.layer.cornerRadius = btn.frame.height / 2.5
    }
    
    func configureTouchableLabel(label: UILabel?, gesture: UITapGestureRecognizer?) {
        if let ges = gesture, let lbl = label {
            lbl.addGestureRecognizer(ges)
            lbl.isUserInteractionEnabled = true
        }
    }
}

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
extension Array {
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
