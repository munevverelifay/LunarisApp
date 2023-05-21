//
//  VerifyEmailViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 7.04.2023.
//

import UIKit

class VerifyEmailViewController: UIViewController {
    
    @IBOutlet weak var backToLoginButton: UIButton!
    @IBOutlet weak var confirmEmailInfoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton(btn: backToLoginButton)
        
        confirmEmailInfoLabel.text = "We have sent you an email at elifay@gmail.com to confirm your email. After receiving the email, follow the link provided to complete registration."
        
    }
}
