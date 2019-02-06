//
//  SignUpViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 2/5/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    var delegate: MainControllerDelegate?
    let logoView: UIImageView = UIImageView().initBasicImage(imageName: "logo")
    let nameTxtBox: UITextField = UITextField().initBasicTxtField(placeHolder: "full name", textSize: 20)
    let emailTxtBox: UITextField = UITextField().initBasicTxtField(placeHolder: "Email", textSize: 20)
    let passwordTxtBox: UITextField = UITextField().initBasicTxtField(placeHolder: "Password", textSize: 20)
    let confirmPasswordTxtBox: UITextField = UITextField().initBasicTxtField(placeHolder: "Password", textSize: 20)
    let RegisterButton: UIButton = UIButton().initBasicButton(title: "Register", titleSize: 25, titleHexColor: "#FFFFFFFF", backGroundHexColor: "#2ecc71")
    
    override func viewWillAppear(_ animated: Bool) {
        emailTxtBox.keyboardType = .emailAddress
        passwordTxtBox.isSecureTextEntry = true
        confirmPasswordTxtBox.isSecureTextEntry = true
        
        
        super .viewWillAppear(true)
        RegisterButton.addTarget(self, action: #selector(performRegister), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoView)
        view.addSubview(emailTxtBox)
        view.addSubview(passwordTxtBox)
        view.addSubview(confirmPasswordTxtBox)
        view.addSubview(RegisterButton)
        view.addSubview(nameTxtBox)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                                     logoView.heightAnchor.constraint(equalToConstant: 200),
                                     logoView.widthAnchor.constraint(equalToConstant: 200),
                                     
                                     
                                     emailTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     emailTxtBox.topAnchor.constraint(equalTo: logoView.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     emailTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     emailTxtBox.widthAnchor.constraint(equalTo: logoView.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     passwordTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordTxtBox.topAnchor.constraint(equalTo: emailTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     passwordTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     passwordTxtBox.widthAnchor.constraint(equalTo: emailTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     confirmPasswordTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     confirmPasswordTxtBox.topAnchor.constraint(equalTo: passwordTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     confirmPasswordTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     confirmPasswordTxtBox.widthAnchor.constraint(equalTo: passwordTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     RegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     RegisterButton.topAnchor.constraint(equalTo: confirmPasswordTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 45),
                                     RegisterButton.heightAnchor.constraint(equalToConstant: 45),
                                     RegisterButton.widthAnchor.constraint(equalTo: confirmPasswordTxtBox.widthAnchor, constant: 0)])
        
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        print("MainViewController Loaded")
    }
    
    
    @objc func performRegister(){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isUserLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
}

