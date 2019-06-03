//
//  SearchViewController.swift
//  CERMATI_TEST
//
//  Created by Ernando Kasaluhe on 03/06/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var results: Results?
    var users = [User]()
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupContentView()
    }
}

//MARK: - Setup
extension SearchViewController {
    func setupContentView() {
        viewSearch.layer.cornerRadius = 5.0
        setupTextField(textField: searchTextField, iconName: "searchIcon")
        setupTableView(withTableView: tableView)
    }
    
    func setupTextField(textField: UITextField, iconName: String) {
        let imageViewLeft = UIImageView(frame: CGRect(x: 5, y: 7, width: 17, height: 16))
        imageViewLeft.image = UIImage(named: iconName)
        let viewLeft: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 32))
        viewLeft.addSubview(imageViewLeft)
        textField.leftView = viewLeft
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func setupTableView(withTableView tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
}

//MARK: - Request and Response API
extension SearchViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(textField: UITextField) {
        users.removeAll()
        if textField.text != "" {
            if textField.text!.count >= 3 {
                Results.getUsers(withQ: textField.text!, andPerPage: 20) { result in
                    switch result {
                        
                    case .success(let response):
                        self.results = response
                        self.users = response.items
                        self.tableView.reloadData()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        } else {
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate and DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell {
            
            let data = users[indexPath.row]
            cell.configureCell(withData: data)
            
            return cell
        } else {
            return SearchTableViewCell()
        }
    }
}
