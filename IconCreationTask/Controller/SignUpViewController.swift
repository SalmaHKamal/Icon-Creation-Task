//
//  SignUpVC.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/14/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit
import SearchTextField
import Toast_Swift
import SwiftyJSON

class SignUpViewController: UITableViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userCountry: SearchTextField!
    @IBOutlet weak var userPass: UITextField!
    @IBOutlet weak var userConfirmPass: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var base64ImageString : String {
        get{
            if let imageData = #imageLiteral(resourceName: "user-image").pngData() as NSData? {
                return imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            }else{
                return ""
            }
        }
        
        set{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarView?.backgroundColor = lightGrayColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    func customizeUI(){
        customizeCountryField()
        customizeUserImg()
        customizeSignupBtn()
        customizeTxtFields(textFields: userName , userEmail , userCountry , userPass ,userConfirmPass )
        customizePasswordTxtField(passTextFiled: userPass)
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let name = userName.text , name != "" ,
        let email = userEmail.text , email != "" ,
        let country = userCountry.text , country != "",
        let password = userPass.text , password != "" ,
        let confirm = userConfirmPass.text , confirm != "" , password == confirm
        else {
            if userConfirmPass.text != userPass.text {
                showToast(msg: "passwords didn't match")
            }else{
                showToast(msg: "All fields are required")
            }

            return
        }

        NetworkServices.signUp(userData: UserModel(_image: base64ImageString ,
                                                   _name: name ,
                                                   _email: email,
                                                   _country: country,
                                                   _password: password)
            , success: { (res) in
                if let value = res as? JSON {
                    if value["status"] == "1" {
                        self.goToLoginVC()
//                        saveInDB()
                        //save state in user defaults
                    }else{
                        self.showToast(msg: value["MessageText"].stringValue)
                    }
                }
                
        }) { (error) in
            if let error = error {
                self.showToast(msg: error.localizedDescription)
            }else{
                self.showToast(msg: "verify that your information is correct or no internet connectivity")
            }
        }

    }
    
    func showToast(msg : String){
        view.makeToast(msg, duration : 2.0 , position : .center )
    }
    
    func goToLoginVC(){
        present(UINavigationController(rootViewController: AgendaViewController()), animated: true, completion: nil)
    }
    
    @IBAction func selectProfileImg(_ sender: Any) {
        
        let titleTxtAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                  NSAttributedString.Key.font : UIFont(name: "Century Gothic", size: 16)!]
        imagePicker.navigationBar.titleTextAttributes = titleTxtAttributes
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: {
            UIApplication.shared.statusBarView?.backgroundColor = satusBarColor
        })
    }
}


extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage {
            userImage.image = pickedImage
            if let imageData = pickedImage.pngData() as NSData? {
                base64ImageString = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            }
        }
        
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
 
}


