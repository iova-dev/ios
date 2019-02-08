//
//  User.swift
//  Lova
//
//  Created by Ramon Geronimo on 2/7/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    let username: String
    let password: String
    
    enum UserCodingKeys: String, CodingKey {
        case username
        case password
    }
}

enum Route:String {
    case login
    case signup
    case logout
}

extension User: CustomStringConvertible {
    var description: String {
        return"?username=\(username)&password=\(password)"
    }
}
