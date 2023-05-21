//
//  forgotPasswordViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.04.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendInstructionsButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTf(tf: emailTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Password")
        
        configureButton(btn: sendInstructionsButton)
        configureButton(btn: backToLoginButton)

     
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    

    @IBAction func sendCodeButton(_ sender: UIButton) {
        if let sendCodeVC = storyboard?.instantiateViewController(withIdentifier: "ConfirmCodeViewController") as? ConfirmCodeViewController {
            self.navigationController?.pushViewController(sendCodeVC, animated: true)
            navigationController?.isNavigationBarHidden = true
        }
    }
}
