//
//  MenuOptionCell.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/30/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    let reUseId = "MenuOptionCell"
    let iconView = UIImageView.initBasicImage(imageName: "settingsImage")
    let buttonDesc = UILabel().initLabel(text: "Sample Text", fontSize: 100, hexcolor: "#FFFFFFFF")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.lightGray
        self.addSubview(iconView)
        iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.addSubview(buttonDesc)
        buttonDesc.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
        buttonDesc.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonDesc.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonDesc.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
