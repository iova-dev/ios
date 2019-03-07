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
    let client = LovaAPIClient()
    //Decalring all the variables going tobe used for this view
    var delegate: CustomAlertViewDelegate?
    let logoView: UIImageView = UIImageView.initBasicImage(imageName: "logo")
    let nameTxtBox: UITextField = UITextField.initBasicTxtField(placeHolder: "full name*", textSize: 20)
    let emailTxtBox: UITextField = UITextField.initBasicTxtField(placeHolder: "Email*", textSize: 20)
    let passwordTxtBox: UITextField = UITextField.initBasicTxtField(placeHolder: "Password*", textSize: 20)
    let confirmPasswordTxtBox: UITextField = UITextField.initBasicTxtField(placeHolder: "Re-Type Password*", textSize: 20)
    let RegisterButton: UIButton = UIButton.initBasicButton(title: "Register", titleSize: 25, titleHexColor: "#FFFFFFFF", backGroundHexColor: "#919191")
    let cancelButton: UIButton = UIButton.initStringButton(textBeforeButton: "", buttonText: "Cancel")
    let passwordErrorLable: UIButton = UIButton.initStringButton(textBeforeButton: "", buttonText: "Password is not strong enough")
      let confirmPasswordErrorLable: UIButton = UIButton.initStringButton(textBeforeButton: "", buttonText: "Password is not the same")
    
    //additional setup before the view can be seen
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        emailTxtBox.keyboardType = .emailAddress
        passwordTxtBox.isSecureTextEntry = true
        confirmPasswordTxtBox.isSecureTextEntry = true
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        passwordErrorLable.isHidden = true
        confirmPasswordErrorLable.isHidden = true
        RegisterButton.addTarget(self, action: #selector(performRegister), for: .touchUpInside)
        passwordTxtBox.addTarget(self, action: #selector(isPasswordValid), for: .editingChanged)
        confirmPasswordTxtBox.addTarget(self, action: #selector(isConfirmPasswordSame), for: .editingChanged)
        passwordTxtBox.textContentType = .newPassword
        confirmPasswordTxtBox.textContentType = .password
        RegisterButton.isEnabled = false
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoView)
        view.addSubview(emailTxtBox)
        view.addSubview(passwordTxtBox)
        view.addSubview(confirmPasswordTxtBox)
        view.addSubview(RegisterButton)
        view.addSubview(nameTxtBox)
        view.addSubview(cancelButton)
        view.addSubview(passwordErrorLable)
        view.addSubview(confirmPasswordErrorLable)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // setting the constraints for all the subviews
                                     logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                                     logoView.heightAnchor.constraint(equalToConstant: 300),
                                     logoView.widthAnchor.constraint(equalToConstant: 300),
                                     
                                     
                                     
                                     nameTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     nameTxtBox.topAnchor.constraint(equalTo: logoView.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     nameTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     nameTxtBox.widthAnchor.constraint(equalTo: logoView.widthAnchor, constant: 0),
                                     
                                     
                                     emailTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     emailTxtBox.topAnchor.constraint(equalTo: nameTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     emailTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     emailTxtBox.widthAnchor.constraint(equalTo: nameTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     passwordTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordTxtBox.topAnchor.constraint(equalTo: emailTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     passwordTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     passwordTxtBox.widthAnchor.constraint(equalTo: emailTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     passwordErrorLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordErrorLable.topAnchor.constraint(equalTo: passwordTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 5),
                                     passwordErrorLable.heightAnchor.constraint(equalToConstant: 15),
                                     passwordErrorLable.widthAnchor.constraint(equalTo: passwordTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     
                                     confirmPasswordTxtBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     confirmPasswordTxtBox.topAnchor.constraint(equalTo: passwordTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 25),
                                     confirmPasswordTxtBox.heightAnchor.constraint(equalToConstant: 45),
                                     confirmPasswordTxtBox.widthAnchor.constraint(equalTo: passwordTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     confirmPasswordErrorLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     confirmPasswordErrorLable.topAnchor.constraint(equalTo: confirmPasswordTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 5),
                                     confirmPasswordErrorLable.heightAnchor.constraint(equalToConstant: 15),
                                     confirmPasswordErrorLable.widthAnchor.constraint(equalTo: confirmPasswordTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     RegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     RegisterButton.topAnchor.constraint(equalTo: confirmPasswordTxtBox.safeAreaLayoutGuide.bottomAnchor, constant: 45),
                                     RegisterButton.heightAnchor.constraint(equalToConstant: 45),
                                     RegisterButton.widthAnchor.constraint(equalTo: confirmPasswordTxtBox.widthAnchor, constant: 0),
                                     
                                     
                                     
                                     cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     cancelButton.topAnchor.constraint(equalTo: RegisterButton.safeAreaLayoutGuide.bottomAnchor, constant: 15),
                                     cancelButton.heightAnchor.constraint(equalToConstant: 45),
                                     cancelButton.widthAnchor.constraint(equalTo: RegisterButton.widthAnchor, constant: 0)])
        
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.becomeFirstResponder()//set so view can be pushed kinda hacky
        print("RegisterViewController Loaded")//debug string
    }
    
    //this is where some of the connection will go.
    @objc func performRegister(){//called when the resgister button is pressed
        guard let user = emailTxtBox.text else {return}
        guard let pass = passwordTxtBox.text else {return}
        client.signup(post: User(username: user, password: pass), view: self) { (error) in
            if let error = error {
                fatalError(error.localizedDescription) // TODO: Error handling operation the server is Down.
            }
        }
    }
    //called when the cancel button is pressed
    @objc func cancelButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //use NSpredicate to validate the password fields
    @objc func isPasswordValid(_ sender: AnyObject?) -> Bool{
        guard let password = sender?.text else{return false}
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        let result = passwordTest.evaluate(with: password)
        
        if result{
            self.passwordErrorLable.setTitle("Password meets requirements", for: .normal)
            self.passwordErrorLable.setTitleColor(.green, for: .normal)
            self.passwordErrorLable.isHidden = false
            
        }else{
            self.passwordErrorLable.setTitle("Password does not meet requirements", for: .normal)
            self.passwordErrorLable.setTitleColor(.red, for: .normal)
            self.passwordErrorLable.isHidden = false
        }
        return result
    }
    
    
    //confirms the password is the same as above
    @objc func isConfirmPasswordSame(_ sender: AnyObject?) -> Bool{
        guard let password = sender?.text else{return false}
        
        var result = false
        
        if password == passwordTxtBox.text {
            self.confirmPasswordErrorLable.setTitle("Password is the same", for: .normal)
            self.confirmPasswordErrorLable.setTitleColor(.green, for: .normal)
            self.confirmPasswordErrorLable.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.RegisterButton.backgroundColor = UIColor.init(hexString: "#2ecc71")
            }
            self.RegisterButton.isEnabled = true
            result = true
        }else{
            self.confirmPasswordErrorLable.setTitle("Password is not the same", for: .normal)
            self.confirmPasswordErrorLable.setTitleColor(.red, for: .normal)
            self.confirmPasswordErrorLable.isHidden = false
            result = false
        }
        return result
    }
    
    
}


