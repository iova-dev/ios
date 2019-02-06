//
//  MenuViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/30/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit


class MenuViewController: UIViewController{
    
    var tableView: UITableView!
    var delegate: MainControllerDelegate?
    let cellId = "MenuOptionCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Menu Loaded")
        configureTableView()
    }
    
    
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
    }
}


extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuOptionCell
        let menuOption = MenuOptions(rawValue: indexPath.row)
        cell.buttonDesc.text = menuOption?.description
        cell.iconView.image = menuOption?.image
        delegate?.handleMenuToggle(forMenuOption: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOptions(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
    
}
