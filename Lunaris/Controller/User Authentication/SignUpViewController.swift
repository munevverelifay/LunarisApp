//
//  SignUpViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.04.2023.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTf(tf: emailTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Email")
        
        configureTf(tf: passwordTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Password")
        
        configureButton(btn: signUpButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSignInlabel))
        configureTouchableLabel(label: signInLabel, gesture: tapGesture)
        
    }
    
    @objc func tappedSignInlabel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if let email = emailTextField.text, let pass = passwordTextField.text {
            let parameters: [String: Any] = [
                "mail": email,
                "pass": pass
            ]
            let url = "https://kouiot.com/elif/signup.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
    }
}
