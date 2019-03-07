//
//  AddPromiseExt.swift
//  Lova
//
//  Created by Wesley Espinoza on 2/27/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit


extension AddPromiseViewController: UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = scrollCollectionView.dequeueReusableCell(withReuseIdentifier: CharityCustomCell.reUseId, for: indexPath) as! CharityCustomCell
        cell.charityName.text = charities[indexPath.row].name
        cell.charityDescription.text = charities[indexPath.row].desc
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.view.sendSubviewToBack(self.finishView)
            self.finishView.alpha = 0
            self.finishView.isUserInteractionEnabled = false
            
        }
        
        UIView.animate(withDuration: 0.5) {
            self.makeCircle(objects: [self.finishButton])
        }
        self.finishButton.titleLabel?.text = "Start!"
        self.finishButton.tag = 1
    }
    

    
    func makeCircle(objects: [AnyObject]){
        for object in objects {
            if object is UIButton{
                object.layer.masksToBounds = false
                object.layer.cornerRadius = object.frame.width / 2
            }else {
                object.layer.masksToBounds = false
                object.layer.cornerRadius = object.frame.width / 20
            }
        }
    }
    
    func makeRound(object: AnyObject){
        
        object.layer.masksToBounds = false
        object.layer.cornerRadius = object.frame.width / 20
        
    }
    
    func giveShadow(object: AnyObject){
        UIView.animate(withDuration: 1.5) {
            object.layer.shadowColor = UIColor.black.cgColor
            object.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            object.layer.shadowRadius = 5
            object.layer.shadowOpacity = 0.5
        }
    }
    
    func removeShadow(object: AnyObject){
        UIView.animate(withDuration: 1.5) {
            object.layer.shadowColor = UIColor.black.cgColor
            object.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            object.layer.shadowRadius = 0
            object.layer.shadowOpacity = 0
        }
    }
    
    
    func configureViews(){
        
        view.addSubview(mainTitle)
        view.addSubview(titleTextBox)
        view.addSubview(subTitle)
        view.addSubview(detailTextBox)
        view.addSubview(willingLabel)
        view.addSubview(subButton)
        view.addSubview(addButton)
        view.addSubview(moneyLabel)
        view.addSubview(backButton)
        view.addSubview(finishView)
        view.addSubview(finishButton)
        
        
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
    
        mainTitle.font = UIFontMetrics.default.scaledFont(for: customFont)
        mainTitle.adjustsFontForContentSizeCategory = true
        subTitle.font = UIFontMetrics.default.scaledFont(for: customFont)
        subTitle.adjustsFontForContentSizeCategory = true
        moneyLabel.font = UIFontMetrics.default.scaledFont(for: customFont2)
        moneyLabel.adjustsFontForContentSizeCategory = true
        finishButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        finishButton.tag = 0
        
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: money as NSNumber) {
            moneyLabel.text = "\(formattedTipAmount)"
        }
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.widthAnchor.constraint(equalToConstant:  25)
        backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        
        mainTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 5).isActive = true
        mainTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingOffset).isActive = true
        mainTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingOffset).isActive = true
        
        titleTextBox.topAnchor.constraint(equalTo: mainTitle.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        titleTextBox.heightAnchor.constraint(equalToConstant: 35).isActive = true
        titleTextBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingOffset).isActive = true
        titleTextBox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingOffset).isActive = true
        
        subTitle.topAnchor.constraint(equalTo: titleTextBox.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingOffset).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingOffset).isActive = true
        
        
        
        detailTextBox.topAnchor.constraint(equalTo: subTitle.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        detailTextBox.heightAnchor.constraint(equalToConstant: 100).isActive = true
        detailTextBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingOffset).isActive = true
        detailTextBox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingOffset).isActive = true
        
        
        willingLabel.topAnchor.constraint(equalTo: detailTextBox.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        willingLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        willingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingOffset).isActive = true
        willingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingOffset).isActive = true
        
        
        
        
        subButton.topAnchor.constraint(equalTo: willingLabel.bottomAnchor, constant: 50).isActive = true
        subButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        subButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingOffset).isActive = true
        subButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        addButton.topAnchor.constraint(equalTo: willingLabel.bottomAnchor, constant: 50).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingOffset).isActive = true
        
        
        
        moneyLabel.topAnchor.constraint(equalTo: willingLabel.bottomAnchor, constant: 50).isActive = true
        moneyLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        moneyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        
        finishView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15).isActive = true
        finishView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        finishView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingOffset).isActive = true
        finishView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingOffset).isActive = true
        
        
        finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        finishButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        finishButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        finishButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        view.layoutIfNeeded()
        makeCircle(objects: [addButton, subButton, detailTextBox, titleTextBox, finishView])
        makeRound(object: finishButton)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            self.giveShadow(object: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
            self.removeShadow(object: textView)
        UIView.animate(withDuration: 1.5) {

        }
        
    }
    
    
    struct charity {
        var name: String?
        var desc: String?
        
        init(name: String, desc: String) {
            self.name = name
            self.desc = desc
        }
    }
}

