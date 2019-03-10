//
//  Promise.swift
//  Lova
//
//  Created by Ramon Geronimo on 2/13/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation

struct Promise: Codable {
    let _id: String?
    let title: String
    let body: String
    let money: Double
    
    enum PromiseCodingKeys: String, CodingKey {
        case _id
        case title
        case body
        case money
    }
}

extension Promise: CustomStringConvertible {
    var description: String {
        return "?title=\(title)&body=\(body)&money=\(money)"
    }
}


