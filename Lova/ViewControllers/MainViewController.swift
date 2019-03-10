//
//  ViewController.swift
//  Lova
//
//  Created by Wesley Espinoza on 1/28/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import UIKit
class MainViewController: UIViewController {
    var collectionView: UICollectionView!
    var addButton: UIButton!
    var promises: [Promise] = []
    var client = PromiseApiService()
    
    func configureAddButton(){
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .white
        addButton.layer.borderColor = UIColor.init(hexString: "#2ecc71").cgColor
        addButton.layer.borderWidth = 1
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        addButton.layer.masksToBounds = false
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.cornerRadius = 37.5
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        
        collectionView.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        addButton.trailingAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
    }
    
    func configureCollectionView(){
        
            // Instantiating the UICollectionView, using the default flow layout
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CustomFlowLayout())
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            collectionView.backgroundColor = .white
            
            // Setting the datasource & delegate
            collectionView.dataSource = self
            collectionView.delegate = self
            
            // Customization
            collectionView.alwaysBounceVertical = true
            
            //Registering the cell
            collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: MainViewCell.reUseId)
            
            view.addSubview(collectionView)
        
    }
    var delegate: MainControllerDelegate?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        if(!isUserLoggedIn()){
            let loginVC = LoginViewController()
            navigationController?.present(loginVC, animated: true, completion: nil)
        }
        client.fetchSources()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionview), name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
        print("Count is: \(promises.count)")

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MainViewController Loaded")
        configureCollectionView()
        configureAddButton()
        // Do any additional setup after loading the view, typically from a nib.
        hideKeyboardWhenTappedAround()

    }
    
    
    @objc func addButtonPressed(_ sender: UIButton){
        let addVC = AddPromiseViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc func reloadCollectionview(){
        self.promises = client.returnSources()
        self.collectionView.reloadData()
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return promises.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCell.reUseId, for: indexPath) as! MainViewCell
        cell.promisetitle?.text = promises[indexPath.row].title
        cell.dueTitle?.text = promises[indexPath.row].body
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
   
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 15, height: collectionView.bounds.height / 8 )
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
struct promise{
    var title: String?
    var startDate: String?
    
    init(title: String, startDate: String) {
        self.title = title
        self.startDate = startDate
    }
}
