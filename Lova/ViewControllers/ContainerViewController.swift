//
//  ContainerViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/30/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewController: UIViewController{
    var menuController: MenuViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super .viewDidLoad()
        configureHomeController()
        
    }
    
    func configureHomeController(){
        let mainController = MainViewController()
        mainController.delegate = self
        centerController = UINavigationController(rootViewController: mainController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController(){
        if menuController == nil{
            menuController = MenuViewController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            
        }
    }
    
    func showMenuController(shouldExpand: Bool, menuOption: MenuOptions?){
        if shouldExpand{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 200
            }, completion: nil)
        } else{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else {return}
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
    }
    
    
    func didSelectMenuOption(menuOption: MenuOptions){
        switch menuOption {
        case .profile:
            print("Profile")
        case .settings:
            print("settings")
        case .other:
            print("other")
        }
    }
}

extension ContainerViewController: MainControllerDelegate{
    func handleMenuToggle(forMenuOption menuOption: MenuOptions?) {
        if !isExpanded{
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
