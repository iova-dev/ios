//
//  MenuOptions.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/31/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

enum MenuOptions: Int, CustomStringConvertible{
    
    case profile
    case settings
    case about
    case logout
    
    var description: String{
        switch self{
        case .profile: return "Profile"
        case .settings: return "Settings"
        case .about: return "About"
        case .logout: return "Logout"
        }
    }
    
    var image: UIImage{
        switch self{
        case .profile: return UIImage(named: "profileImage") ?? UIImage()
        case .settings: return UIImage(named: "settingsImage") ?? UIImage()
        case .about: return UIImage(named: "aboutImage") ?? UIImage()
        case .logout: return UIImage(named: "logoutImage") ?? UIImage()
        }
    }
    
    
}
