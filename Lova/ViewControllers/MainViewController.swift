//
//  ViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/28/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let button = UIButton().initBasicButton(title: "test Button", titleSize: 24, titleHexColor: "#99999", backGroundHexColor: "#2ecc71")
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(button)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     button.heightAnchor.constraint(equalToConstant: 50),
                                     button.widthAnchor.constraint(equalToConstant: 100)])
        
        if (!isUserLoggedIn()){
            let vcToPresent = LoginViewController()
            navigationController?.present(vcToPresent, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

