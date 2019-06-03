//
//  SearchViewController.swift
//  CERMATI_TEST
//
//  Created by Ernando Kasaluhe on 03/06/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit
import ESPullToRefresh

class SearchViewController: UIViewController {

    var results: Results?
    var users = [User]()
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var totalUsers: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupContentView()
        pullBottomTableView()
    }
}

//MARK: - Setup
extension SearchViewController {
    func setupContentView() {
        viewSearch.layer.cornerRadius = 5.0
        setupTextField(textField: searchTextField, iconName: "searchIcon")
        setupTableView(withTableView: tableView)
        setupRefreshControl(withRefreshControl: refreshControl)
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
    
    func setupRefreshControl(withRefreshControl refreshControl: UIRefreshControl) {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
}

//MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text != "" {
            if textField.text!.count >= 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.requestSearchUser(withQ: textField.text!, andPerPage: 20)
                }
            }
        } else {
            self.users.removeAll()
            self.tableView.reloadData()
        }
    }
}

//MARK: - Request and Response API
extension SearchViewController {
    func requestSearchUser(withQ q: String, andPerPage perPage: Int) {
        Results.getUsers(withQ: q, andPerPage: perPage) { result in
            switch result {
                
            case .success(let response):
                self.results = response
                self.totalUsers = response.totalCount!
                self.users = response.items
                self.refreshControl.endRefreshing()
                self.tableView.es.stopLoadingMore()
                self.tableView.reloadData()
            case .failure(let failure):
                print(failure)
                self.refreshControl.endRefreshing()
                self.tableView.es.stopLoadingMore()
                self.tableView.es.noticeNoMoreData()
                self.tableView.es.stopPullToRefresh()
                self.tableView.reloadData()
            }
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

//MARK: - Action
extension SearchViewController {
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            
            self.requestSearchUser(withQ: self.searchTextField.text!, andPerPage: 20)
            self.tableView.es.resetNoMoreData()
        }
    }
    
    func pullBottomTableView() {
        tableView.es.addInfiniteScrolling {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                
                let perPage = self.users.count + 10
                if self.users.count != self.totalUsers {
                    self.requestSearchUser(withQ: self.searchTextField.text!, andPerPage: perPage)
                } else {
                    self.tableView.es.stopLoadingMore()
                    self.tableView.es.noticeNoMoreData()
                    self.tableView.es.stopPullToRefresh()
                }
            }
        }
    }
}
