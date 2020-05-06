//
//  UsersListVC.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import PKHUD

class UsersListVC: UIViewController {
    
    let tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var userListPresenter = UsersListPresenter()
    var usersList = [UsersListItem]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userListPresenter.viewDelegate = self
        view.backgroundColor = .white
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userListPresenter.viewIsPrepared()
        customizeNavigationBar(animated)
    }

    // MARK: - Custom Functions
    func customizeNavigationBar(_ animated: Bool) {
        title = "Users"
        navigationController?.navigationBar.barTintColor = .white

    }
    
    func setupTableView() {
        view.addSubview(tableView)
        configureConstraintsForTableView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.Identifier)
        
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        userListPresenter.onRefreshSwiped()
    }

    func configureConstraintsForTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: - UITableView Delegate & DataSource
extension UsersListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.Identifier, for: indexPath) as! UserCell
        let currentUser = usersList[indexPath.row]
        cell.configureWithUser(user: currentUser)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userListPresenter.userSelected(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UsersListVC: UsersListViewDelegate {
    func showUsers(_ users: [UsersListItem]) {
        usersList = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showDownloadUserAlbumsDataError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
    
    func showUserAlbums() {
        let albumsListVC = AlbumsListVC()
        navigationController?.pushViewController(albumsListVC, animated: false)
    }
    
    func showProgress() {
        HUD.show(.progress)
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            HUD.hide()
        }
    }
}
