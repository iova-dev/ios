//
//  LoginViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/29/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    var delegate: MainControllerDelegate?
    let logoView: UIImageView = UIImageView().initBasicImage(imageName: "logo")
    let emailTxtBox: UITextField = UITextField().initBasicTxtField(placeHolder: "Email", textSize: 20)
    let passWordTxtBox: UITextField = UITextField().initBasicTxtField(placeHolder: "Password", textSize: 20)
    let tagLine: UILabel = UILabel().initLabel(text: "Welcome back, \("Buzz")", fontSize: 75, hexcolor: "#c6c6c6")
    let logInButton: UIButton = UIButton().initBasicButton(title: "Log in", titleSize: 25, titleHexColor: "#FFFFFFFF", backGroundHexColor: "#2ecc71")
    let createButton: UIButton = UIButton().initStringButton(textBeforeButton: "Don't have an account?", buttonText: "Create an account!")
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        logInButton.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(performRegister), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoView)
        view.addSubview(emailTxtBox)
        view.addSubview(passWordTxtBox)
        view.addSubview(tagLine)
        view.addSubview(logInButton)
        view.addSubview(createButton)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                                     logoView.heightAnchor.constraint(equalToConstant: 300),
                                     logoView.widthAnchor.constraint(equalToConstant: 300),
                                     
                                     
                                     
                                     tagLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     tagLine.topAnchor.constraint(equalTo: logoView.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     tagLine.heightAnchor.constraint(equalToConstant: 25),
                                     tagLine.widthAnchor.constraint(equalTo: logoView.widthAnchor, constant: 0),
                                     
                                     
                                     emailTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     emailTxtBox.topAnchor.constraint(equalTo: tagLine.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     emailTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     emailTxtBox.widthAnchor.constraint(equalTo: logoView.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     passWordTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passWordTxtBox.topAnchor.constraint(equalTo: emailTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     passWordTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     passWordTxtBox.widthAnchor.constraint(equalTo: emailTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     
                                     logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     logInButton.topAnchor.constraint(equalTo: passWordTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 45),
                                     logInButton.heightAnchor.constraint(equalToConstant: 45),
                                     logInButton.widthAnchor.constraint(equalTo: passWordTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     
                                     createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 85),
                                     createButton.topAnchor.constraint(equalTo: logInButton.safeAreaLayoutGuide.bottomAnchor, constant: 75),
                                     createButton.heightAnchor.constraint(equalToConstant: 45),
                                     createButton.widthAnchor.constraint(equalToConstant: 350)])
        
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        print("MainViewController Loaded")
    }
    
    
    @objc func performLogin(){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isUserLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func performRegister(){
            let nextVC = RegisterViewController()
            navigationController?.present(nextVC, animated: true, completion: nil)
    }
    
}
