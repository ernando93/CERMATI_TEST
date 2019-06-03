//
//  SearchViewController.swift
//  CERMATI_TEST
//
//  Created by Ernando Kasaluhe on 03/06/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

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
    }
    
    func setupTableView(withTableView tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
}

//MARK: - TableView Delegate and DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell {
            
            return cell
        } else {
            return SearchTableViewCell()
        }
    }
}
