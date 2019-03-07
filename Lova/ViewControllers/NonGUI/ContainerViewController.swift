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
    let client = LovaAPIClient()
    var menuController: MenuViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super .viewDidLoad()
        print("Constainer Loaded")
        configureHomeController()
        configureNavigation()
    }
    
    
    func configureNavigation(){
        //navigationController?.navigationBar.layer
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.init(hexString: "#2ecc71")
        navigationItem.title = "Lova"
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/10, height: view.frame.height))
        titleLable.text = "Lova"
        titleLable.font = UIFont(name: "Raleway-Regular", size: 40)
        titleLable.textColor = .white
        navigationItem.titleView = titleLable
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "sideMenuButtonImage"), style: .plain, target: self, action: #selector(showSideMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
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
            addChild(menuController)
            view.insertSubview(menuController.view, at: 0)
            menuController.didMove(toParent: self)
        }
    }
    
    func configureLoginController(){
        let nextVC = LoginViewController()
        navigationController?.present(nextVC, animated: true, completion: nil)
    }
    
    func configureRegisterController(){
        let nextVC = RegisterViewController()
        navigationController?.present(nextVC, animated: true, completion: nil)
    }
    
    
    func showMenuController(shouldExpand: Bool, menuOption: MenuOptions?){
        if shouldExpand{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 200
                self.centerController.view.alpha = 0.7
            }, completion: nil)
        } else{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                self.centerController.view.alpha = 1
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
        case .logout:
            logout()
        case .about:
            print("About")
        }
    }
    @objc func showSideMenu(){
        handleMenuToggle(forMenuOption: nil)
    }
}

extension ContainerViewController: MainControllerDelegate{
    func login() {
    }
    
    func logout() {
        client.logout(completion: nil)
        navigationController?.present(LoginViewController(), animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
    }
    
    
    func handleMenuToggle(forMenuOption menuOption: MenuOptions?) {
        if !isExpanded{
            configureMenuController()
        }
        
        showMenuController(shouldExpand: isExpanded, menuOption: menuOption)
        isExpanded = !isExpanded
    }
}
