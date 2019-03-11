//
//  Protocols.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/30/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation

protocol MainControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOptions?)
    func login()
    func logout()
}

protocol reloadDataDelagate {
    func reloadData()
}

protocol CustomAlertViewDelegate{
    func registerButtonPressed(email: String)
}
