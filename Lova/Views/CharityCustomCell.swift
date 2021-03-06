//
//  CharityCustomCell.swift
//  Lova
//
//  Created by Wesley Espinoza on 3/3/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

class CharityCustomCell: UICollectionViewCell {
    static var reUseId = "CharityCell"
    
    var charityName: UILabel!
    var charityDescription: UILabel!
    
    func configureViews(){
        guard let customFont = UIFont(name: "Raleway-Bold", size: UIFont.labelFontSize) else {
            fatalError("""
    Failed to load the "Raleway-Bold" font.
    Make sure the font file is included in the project and the font name is spelled correctly.
    """
            )
        }
        guard let customFont2 = UIFont(name: "Lusitana", size: UIFont.labelFontSize) else {
            fatalError("""
    Failed to load the "Raleway-Bold" font.
    Make sure the font file is included in the project and the font name is spelled correctly.
    """
            )
        }
        

        charityName = UILabel()
        charityDescription = UILabel()
        

        charityName.font = UIFontMetrics.default.scaledFont(for: customFont)
        charityName.text = "Error getting Title"
        charityDescription.font = UIFontMetrics.default.scaledFont(for: customFont2)
        charityDescription.text = "Error getting due date"
        
        

        charityName.translatesAutoresizingMaskIntoConstraints = false
        charityDescription.translatesAutoresizingMaskIntoConstraints = false
        

        self.contentView.addSubview(charityName)
        self.contentView.addSubview(charityDescription)

        
        charityName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        charityName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        
        
        
        charityDescription.topAnchor.constraint(equalTo: charityName.bottomAnchor, constant: 15).isActive = true
        charityDescription.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        // Customization
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.init(hexString: "#696969")
        self.layer.cornerRadius = 15
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        
        
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // prepares the cell fo reuse
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // sets the alpha to 0.5 when a user presses and holds a view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.alpha = 0.5
        
    }
    // sets the alpha back once the user lets go
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
    
    
}
