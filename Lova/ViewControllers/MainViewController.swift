//
//  ViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/28/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var delegate: MainControllerDelegate?
    let button = UIButton().initBasicButton(title: "test Button", titleSize: 24, titleHexColor: "#AAAAAAA", backGroundHexColor: "#2ecc71")

    
    override func viewWillAppear(_ animated: Bool) {
        
        button.addTarget(self, action: #selector(performLogout), for: .touchUpInside)
        view.addSubview(button)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     button.heightAnchor.constraint(equalToConstant: 50),
                                     button.widthAnchor.constraint(equalToConstant: 100),
                                     ])
        
        if (!isUserLoggedIn()){
            let vcToPresent = LoginViewController()
            navigationController?.present(vcToPresent, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureNavigation()
    }

    @objc func performLogout(){
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isUserLoggedIn")
    }
    
    @objc func showSideMenu(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    
    func configureNavigation(){
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
    }

}

