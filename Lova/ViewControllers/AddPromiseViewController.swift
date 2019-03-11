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
    var client = LovaAPIClient()
    var delegate: reloadDataDelagate?
    let trailingOffset: CGFloat = -25
    let leadingOffset: CGFloat = 25
    var mainTitle = UILabel.createLabel(text: "I promise to...", alignment: .left)
    var titleTextBox = UITextView.createTextField(maxLines: 1)
    var subTitle = UILabel.createLabel(text: "Additional details", alignment: .left)
    var detailTextBox = UITextView.createTextField(maxLines: 6)
    var willingLabel = UILabel.createLabel(text: "My willingness to complete my promise", alignment: .left)
    var subButton = UIButton.createButton(titleLabel: "-")
    var addButton = UIButton.createButton(titleLabel: "+")
    var finishView = UIView.createView(bgColor: UIColor.init(hexString: "#2ecc71"))
    var backButton = UIButton.createButton(titleLabel: "Cancel")
    var finishButton = UIButton.createButton(titleLabel: "pick a Charity")
    var money: Double = 0.0
    var moneyLabel = UILabel.createLabel(text: "$0.00", alignment: .center)
    let formatter = NumberFormatter()
    var scrollCollectionView: UICollectionView!
    var charities: [charity] = []
    
    
    
    func configureCollectionView(){
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize.height = 100
        layout.itemSize.width = 200
        scrollCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        scrollCollectionView.setCollectionViewLayout(layout, animated: true)
        scrollCollectionView.backgroundColor = .clear
        scrollCollectionView.register(CharityCustomCell.self, forCellWithReuseIdentifier: CharityCustomCell.reUseId)
        scrollCollectionView.translatesAutoresizingMaskIntoConstraints = false
        finishView.addSubview(scrollCollectionView)
        
        NSLayoutConstraint.activate([scrollCollectionView.topAnchor.constraint(equalTo: finishView.safeAreaLayoutGuide.topAnchor, constant: 25),
                                     scrollCollectionView.leadingAnchor.constraint(equalTo: finishView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                                     scrollCollectionView.trailingAnchor.constraint(equalTo: finishView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                                     scrollCollectionView.bottomAnchor.constraint(equalTo: finishView.safeAreaLayoutGuide.bottomAnchor, constant: -25)])
        scrollCollectionView.delegate = self
        scrollCollectionView.dataSource = self
        view.layoutIfNeeded()
        makeCircle(objects: [scrollCollectionView])
        
            self.finishView.alpha = 0
            self.finishView.isUserInteractionEnabled = false
    self.view.sendSubviewToBack(self.finishView)
    
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //additional set up to get view ready
        super .viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        addButton.addTarget(self, action: #selector(addedMoney), for: .touchUpInside)
        subButton.addTarget(self, action: #selector(subMoney), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        popCharities()
        view.backgroundColor = .white
        titleTextBox.delegate = self
        detailTextBox.delegate = self
         configureViews()
        configureCollectionView()
        backButton.backgroundColor = UIColor.clear
        backButton.layer.borderWidth = 0
        backButton.layer.shadowOpacity = 0
        hideKeyboardWhenTappedAround()
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
    
    
    @objc func finishButtonPressed(){
        
        switch (finishButton.tag) {
        case 0:
            UIView.animate(withDuration: 0.3) {
                self.view.sendSubviewToBack(self.finishButton)
                self.finishView.alpha = 1
                self.finishView.isUserInteractionEnabled = true
                self.finishView.frame.origin.y -= 200
            }
            break
        case 1:
            guard let title = titleTextBox.text, let body = detailTextBox.text else {return}
            client.create(post: Promise(_id: nil, title: title, body: body, money: money), view: self) { (error) in
                if let error = error {
                    fatalError(error.localizedDescription) // TODO: Error handling operation the server is Down.
                }
            }
            navigationController?.popViewController(animated: true)
            break
        default:
            print("should not be here")
        }
        self.delegate?.reloadData()
    }
    
    @objc func cancelPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func backButtonPressed(){
        navigationController?.popViewController(animated: true)
        
        
    }
    
    func popCharities(){
        let char = charity(name: "Lungevity Foundation", desc: "Lung Cancer charity")
        let char2 = charity(name: "Acumen", desc: "low income community")
        let char3 = charity(name: "CARE", desc: "disaster releife")
            charities.append(char)
            charities.append(char2)
            charities.append(char3)
    }

}
//extension to access the registers views info.


