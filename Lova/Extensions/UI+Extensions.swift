//
//  ViewController+Extensions.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/29/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func initBasicButton( title: String, titleSize: CGFloat, titleHexColor: String, backGroundHexColor: String) -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleSize)
        button.setTitleColor(UIColor.init(hexString: titleHexColor), for: .normal)
        button.backgroundColor = UIColor.init(hexString: backGroundHexColor)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 15
        return button
    }
}


extension UITextField {
    
    func initBasicTxtField(_ placeHolder: String, backGroundHexColor: String) -> UITextField{
        let txtField = UITextField()
        txtField.backgroundColor = UIColor.init(hexString: backGroundHexColor)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = placeHolder
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.layer.borderWidth = 1
        txtField.layer.shadowColor = UIColor.black.cgColor
        txtField.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        txtField.layer.masksToBounds = false
        txtField.layer.shadowRadius = 5
        txtField.layer.shadowOpacity = 0.5
        txtField.layer.cornerRadius = 15
        return txtField
    }
    
}

extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 125
            }
        }
        
    }
    
    @objc func keyboardWillHide(){
        self.view.frame.origin.y = 0
        
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
