//
//  SignupViewControllerEx.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit
import SearchTextField
import SnapKit
import SwiftyJSON
import Toast_Swift

extension SignUpViewController {
    
    var showPassClick : Bool {
        get {
            return false
        }
        
        set {
            
        }
    }
    
    func customizeCountryField() {
        var countriesArray = [String]()
        //get countries
        NetworkServices.getCountriesList(success: { (value) in
            if let values = value as? JSON {
                for singleValue in values {
                    countriesArray.append(singleValue.1["name"].stringValue)
                }
                self.userCountry.filterStrings(countriesArray)
            }
        }) { (error) in
            if let error = error {
                self.showToast(msg: error.localizedDescription)
            }else{
                self.showToast(msg: "something wrong happened while getting countries list")
            }
        }
        
        userCountry.theme = SearchTextFieldTheme.darkTheme()
    }
    
    func customizeUserImg(){
        imagePicker.delegate = self
        userImage.image = UIImage(named: "user-image")
        userImage.layer.cornerRadius = 60
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = blueThemeColor.cgColor
    }
    
    func customizeSignupBtn(){
        signupButton.backgroundColor = blueThemeColor
    }
    
    func customizeTxtFields(textFields : UITextField...){
 
        for txtField in textFields {
            txtField.textColor = darkGrayColor
            
            let bottomView = createBottomBorder()
            txtField.addSubview(bottomView)
            bottomView.leadingAnchor.constraint(equalTo: txtField.leadingAnchor, constant: 0).isActive = true
            bottomView.rightAnchor.constraint(equalTo: txtField.rightAnchor, constant: 0).isActive = true
            bottomView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            bottomView.bottomAnchor.constraint(equalTo: txtField.bottomAnchor, constant: 0).isActive = true
        }

    }
    
    func customizePasswordTxtField(passTextFiled : UITextField){
        let showPassBtn = UIButton()
        showPassBtn.setBackgroundImage(#imageLiteral(resourceName: "hide"), for: .normal)
        showPassBtn.addTarget(self, action: #selector(showPassPressed), for: .touchUpInside)
        passTextFiled.addSubview(showPassBtn)

        //add long press recognizer
//        let longPress = UILongPressGestureRecognizer(target: SignUpViewController.self, action: #selector(showPassPressed(longPressGestureRecognizer:)))
//        showPassBtn.addGestureRecognizer(longPress)
        //constraints
        showPassBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(passTextFiled)
            make.centerY.equalTo(passTextFiled)
            make.height.width.equalTo(15)
        }
    }
    
    @objc func showPassPressed(){ //longPressGestureRecognizer: UILongPressGestureRecognizer
        print("clcikeccccc")
        if(showPassClick == true) {
            userPass.isSecureTextEntry = false
        } else {
            userPass.isSecureTextEntry = true
        }

        showPassClick = !showPassClick
    }

    
    func createBottomBorder() -> UIView {
        let lineView = UIView()
        lineView.backgroundColor = normalGrayColor
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }
}
