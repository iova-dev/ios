//
//  ViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/28/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import UIKit
class MainViewController: UIViewController {
    var tableView: UITableView!
    let cellId = "MainCell"
    
    
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.sizeToFit()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
    }
    var delegate: MainControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        if(!isUserLoggedIn()){
            let loginVC = RegisterViewController()
            navigationController?.present(loginVC, animated: true, completion: nil)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainViewController Loaded")
        configureTableView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell
        
        return cell
    }
    
}

