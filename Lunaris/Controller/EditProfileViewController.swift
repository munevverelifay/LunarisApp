//
//  EditProfileViewController.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 10.04.2023.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var editCoverImage: UIImageView!
    @IBOutlet weak var editCoverImageButton: UIButton!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var editProfilePictureImage: UIImageView!
    @IBOutlet weak var editProfilePictureImageButton: UIButton!
    @IBOutlet weak var editProfilNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var saveEditButton: UIButton!
    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var editUserNameTextField: UITextField!
    @IBOutlet weak var editEmailTextField: UITextField!
    @IBOutlet weak var editPasswordTextField: UITextField!
    
    var profilePictureControlButton: Bool = false
    var coverControlButton: Bool = false
    
    var profileImageData: Data?
    var coverImageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        configureUserProfilImage(userProfil: profilePictureImage)
        configureButton(btn: saveEditButton)
        
        editProfilePictureImage.layer.cornerRadius = editProfilePictureImage.frame.height / 2
        editCoverImage.layer.cornerRadius = editProfilePictureImage.frame.height / 2
        configureTf(tf: editNameTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Name")
        configureTf(tf: editUserNameTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "User Name")
        configureTf(tf: editEmailTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Email")
        configureTf(tf: editPasswordTextField, bgColor: UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), placeHolder: "Password")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if profilePictureControlButton {
                profilePictureImage.image = selectedImage
                profileImageData = selectedImage.pngData()
                // imageData'ı saklayabilirsiniz
            } else if coverControlButton {
                coverImage.image = selectedImage
                coverImageData = selectedImage.pngData()
                // imageData'ı saklayabilirsiniz
            }
        }
       dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       dismiss(animated: true, completion: nil)
    }
    

    @IBAction func editProfilePictureButtonTapped(_ sender: UIButton) {
        profilePictureControlButton = true
        coverControlButton = false
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func editCoverButtonTapped(_ sender: UIButton) {
        profilePictureControlButton = false
        coverControlButton = true
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func saveEditButtonTapped(_ sender: UIButton) {
        print(editNameTextField.text!)
        print(editUserNameTextField.text!)
        print(editEmailTextField.text!)
        print(editPasswordTextField.text!)
//        NotificationCenter.default.post(name: .notificationProfile, object: nil)
        // profil resmi ve kapak fotoğrafı için saklanan veriler
        if profileImageData != nil {
      
            print("profil degisti")
            
        }
        if coverImageData != nil {

            print("cover degisti")
        }
    }
    
}
