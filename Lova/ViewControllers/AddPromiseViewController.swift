//
//  AddPromiseViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 2/11/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//


import Foundation
import UIKit

class AddPromiseViewController: UIViewController {
    //initial set up
    var delegate: MainControllerDelegate?
    
    var mainTitle: UILabel!
    var titleTextBox: UITextView!
    var subTitle: UILabel!
    var detailTextBox: UITextView!
    var willingLabel: UILabel!
    var subButton: UIButton!
    var addButton: UIButton!
    var startPromise: UIButton!
    var backButton: UIButton!
    var money: Double!
    var moneyLabel: UILabel!
    let formatter = NumberFormatter()
  
    
    func configureViews(){
        guard let customFont = UIFont(name: "Raleway-Regular", size: UIFont.labelFontSize) else {
            fatalError("""
    Failed to load the "Raleway-Bold" font.
    Make sure the font file is included in the project and the font name is spelled correctly.
    """
            )
        }
        
        guard let customFont2 = UIFont(name: "Raleway-Regular", size: 45) else {
            fatalError("""
    Failed to load the "Raleway-Bold" font.
    Make sure the font file is included in the project and the font name is spelled correctly.
    """
            )
        }
        money = 0.00
        mainTitle = UILabel()
        titleTextBox = UITextView()
        subTitle = UILabel()
        detailTextBox = UITextView()
        willingLabel = UILabel()
        subButton = UIButton()
        addButton = UIButton()
        backButton = UIButton()
        startPromise = UIButton()
        moneyLabel = UILabel()
        mainTitle.font = UIFontMetrics.default.scaledFont(for: customFont)
        mainTitle.adjustsFontForContentSizeCategory = true
        subTitle.font = UIFontMetrics.default.scaledFont(for: customFont)
        subTitle.adjustsFontForContentSizeCategory = true
        moneyLabel.font = UIFontMetrics.default.scaledFont(for: customFont2)
        moneyLabel.adjustsFontForContentSizeCategory = true
        
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: money as NSNumber) {
            moneyLabel.text = "\(formattedTipAmount)"
        }
       
        
        

        moneyLabel.textAlignment = .center
        
        mainTitle.text = "I promise to ..."
        willingLabel.text = "My willingness to complete my promise."
        titleTextBox.layer.borderWidth = 0.5
        titleTextBox.textContainer.maximumNumberOfLines = 1
        
        subTitle.text = "Additional Notes"
        
        detailTextBox.layer.borderWidth = 0.5
        detailTextBox.textContainer.maximumNumberOfLines = 6
        
        
        
        backButton.setTitle("Cancel", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        backButton.setTitleColor(.black, for: .normal)
        backButton.backgroundColor = .white
        backButton.layer.borderColor = UIColor.init(hexString: "#2ecc71").cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        backButton.layer.masksToBounds = false
        backButton.layer.shadowRadius = 5
        backButton.layer.shadowOpacity = 0.5
        backButton.layer.cornerRadius = 10
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        
        
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .white
        addButton.layer.borderColor = UIColor.init(hexString: "#2ecc71").cgColor
        addButton.layer.borderWidth = 1
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        addButton.layer.masksToBounds = false
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.cornerRadius = 37
        addButton.addTarget(self, action: #selector(addedMoney), for: .touchUpInside)
        
        
        
        subButton.setTitle("-", for: .normal)
        subButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        subButton.setTitleColor(.black, for: .normal)
        subButton.backgroundColor = .white
        subButton.layer.borderColor = UIColor.init(hexString: "#2ecc71").cgColor
        subButton.layer.borderWidth = 1
        subButton.layer.shadowColor = UIColor.black.cgColor
        subButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        subButton.layer.masksToBounds = false
        subButton.layer.shadowRadius = 5
        subButton.layer.shadowOpacity = 0.5
        subButton.layer.cornerRadius = 37
        subButton.addTarget(self, action: #selector(subMoney), for: .touchUpInside)
        
        startPromise.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        startPromise.setTitle("""
start your
Promise!
""", for: .normal)
        startPromise.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        startPromise.setTitleColor(.black, for: .normal)
        startPromise.backgroundColor = .white
        startPromise.layer.borderColor = UIColor.init(hexString: "#2ecc71").cgColor
        startPromise.layer.borderWidth = 1
        startPromise.layer.shadowColor = UIColor.init(hexString: "#2ecc71").cgColor
        startPromise.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        startPromise.layer.masksToBounds = false
        startPromise.layer.shadowRadius = 50
        startPromise.layer.shadowOpacity = 0.5
        startPromise.layer.cornerRadius = 76
        startPromise.addTarget(self, action: #selector(startPromisePressed), for: .touchUpInside)
        
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        titleTextBox.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        detailTextBox.translatesAutoresizingMaskIntoConstraints = false
        willingLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        subButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        startPromise.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(mainTitle)
        view.addSubview(titleTextBox)
        view.addSubview(subTitle)
        view.addSubview(detailTextBox)
        view.addSubview(willingLabel)
        view.addSubview(subButton)
        view.addSubview(addButton)
        view.addSubview(moneyLabel)
        view.addSubview(startPromise)
        view.addSubview(backButton)
        
        
        
        
        
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: (view.bounds.width/1.4)).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        
        mainTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 5).isActive = true
        mainTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        mainTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        
        titleTextBox.topAnchor.constraint(equalTo: mainTitle.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        titleTextBox.heightAnchor.constraint(equalToConstant: 35).isActive = true
        titleTextBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        titleTextBox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        
        subTitle.topAnchor.constraint(equalTo: titleTextBox.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        
        
        
        detailTextBox.topAnchor.constraint(equalTo: subTitle.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        detailTextBox.heightAnchor.constraint(equalToConstant: 100).isActive = true
        detailTextBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        detailTextBox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        
        
        willingLabel.topAnchor.constraint(equalTo: detailTextBox.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        willingLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        willingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        willingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        
        
        
        
        subButton.topAnchor.constraint(equalTo: willingLabel.bottomAnchor, constant: 50).isActive = true
        subButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        subButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        subButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1*(view.bounds.width/1.3)).isActive = true
        
        
        
        addButton.topAnchor.constraint(equalTo: willingLabel.bottomAnchor, constant: 50).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: (view.bounds.width/1.3)).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        
        
        moneyLabel.topAnchor.constraint(equalTo: willingLabel.bottomAnchor, constant: 50).isActive = true
        moneyLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        moneyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        moneyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        
        startPromise.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 100).isActive = true
        startPromise.heightAnchor.constraint(equalToConstant: 150).isActive = true
        startPromise.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 110).isActive = true
        startPromise.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -110).isActive = true
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        //additional set up to get view ready
        super .viewWillAppear(true)
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = .white
       configureViews()
    }
    
    
    @objc func addedMoney(){
        money += 1.00
        
        UIView.animate(withDuration: 0.5) {
            if let formattedTipAmount = self.formatter.string(from: self.money as NSNumber) {
                self.moneyLabel.text = "\(formattedTipAmount)"
            }
        }
    }
    
    @objc func subMoney(){
        if money > 0{
            money -= 1.00
        }
        
        UIView.animate(withDuration: 0.5) {
            if let formattedTipAmount = self.formatter.string(from: self.money as NSNumber) {
                self.moneyLabel.text = "\(formattedTipAmount)"
            }
        }
    }
    
    
    @objc func startPromisePressed(){
       
    
    }
    
    
    @objc func backButtonPressed(){
        
        navigationController?.popViewController(animated: true)
    }
}
//extension to access the registers views info.


