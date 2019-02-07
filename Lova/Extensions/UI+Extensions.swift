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
    // creates a basic button with given parameters
    func initBasicButton( title: String, titleSize: CGFloat, titleHexColor: String, backGroundHexColor: String) -> UIButton{
        let button = UIButton()
        guard let customFont = UIFont(name: "Lusitana", size: UIFont.labelFontSize) else {
            fatalError("""
        Failed to load the "Raleway-Bold" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.init(hexString: titleHexColor), for: .normal)
        button.backgroundColor = UIColor.init(hexString: backGroundHexColor)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }
    
    
    
    
    
    func initStringButton(textBeforeButton: String, buttonText: String) -> UIButton{
        let button = UIButton()
        guard let customFont = UIFont(name: "Lusitana", size: UIFont.labelFontSize) else {
            fatalError("""
        Failed to load the "Raleway-Bold" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#2ecc71"), for: .normal)
        button.backgroundColor = UIColor.init(hexString: "#FFFFFFF", alpha: 0)
        let label = UILabel().initLabel(text: textBeforeButton, fontSize: 15, hexcolor: "#0000000")
        label.textAlignment = .right
        button.addSubview(label)
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: button.topAnchor, constant: 0),
                                     label.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 1),
                                     label.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 0)])
        return button
        
    }
}

extension UITableView{
    func initFullTableView()->UITableView{
        let table = UITableView(frame: .infinite)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }
}

extension UITextField {
    // creates a basic text Field with given parameters. ex: let basic txtField = UITextField().initBasicTxtField(placeHolder: "place holder text, textSize: 20, backGroundHexColor: "#9875AA"")
    func initBasicTxtField(placeHolder: String, textSize: CGFloat) -> UITextField{
        let txtField = UITextField()
        guard let customFont = UIFont(name: "Lusitana", size: UIFont.labelFontSize) else {
            fatalError("""
        Failed to load the "lusitana" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        txtField.font = UIFontMetrics.default.scaledFont(for: customFont)
        txtField.adjustsFontForContentSizeCategory = true
        txtField.backgroundColor = UIColor.init(hexString: "#FFFFFFF", alpha: 0)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = placeHolder
        txtField.borderStyle = .none
        txtField.layer.backgroundColor = UIColor.white.cgColor
        txtField.layer.masksToBounds = false
        txtField.layer.shadowColor = UIColor.gray.cgColor
        txtField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        txtField.layer.shadowOpacity = 1.0
        txtField.layer.shadowRadius = 0.0

        return txtField
    }
}

extension UILabel {
    func initLabel(text: String, fontSize: CGFloat,  hexcolor: String) -> UILabel{
        let label = UILabel()
        guard let customFont = UIFont(name: "Raleway-Regular", size: UIFont.labelFontSize) else {
            fatalError("""
        Failed to load the "Raleway-Bold" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = UIColor.init(hexString: hexcolor)
        label.clipsToBounds = true
        label.layer.masksToBounds = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}


extension UIImageView {
    func initBasicImage(imageName: String) -> UIImageView{
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }
}

extension UIView{
    func initSideMenu() -> UIView{
        let menu = UIView()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.backgroundColor = UIColor.init(hexString: "#2ecc71")
        return menu
    }
}

extension UIViewController{
    
    //allows the user to tap anywhere to get rid of the keyboard. [UX] call it on any ViewController's viewdidLoad()
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
    
    // Function that will allow user to stay logged in.
    func isUserLoggedIn()->Bool{
        let defaults = UserDefaults.standard
       let log = defaults.bool(forKey: "isUserLoggedIn")
        if log {
            return true
        }else{
            return false
        }
    }
}

extension UIColor {
    //this extensions allows the devs to use hex as UIColors. ex. let red = UIColor.init(hexString "#000000")
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
