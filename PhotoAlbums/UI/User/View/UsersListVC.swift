//
//  UsersListVC.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import PKHUD
import RxSwift

class UsersListVC: UIViewController {
    
    // MARK: - RxSwift Properties
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var userListViewModel = UserViewModel()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userListViewModel.viewDelegate = self
        view.backgroundColor = .white
        setupTableView()
        setupUsersObserver()
        setupCellConfiguration()
        setupCellTapHandling()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userListViewModel.viewIsPrepared()
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

        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.Identifier)
        
        configureRefreshControl()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        userListViewModel.onRefreshSwiped()
    }

    func configureConstraintsForTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: - UITableView Delegate
extension UsersListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension UsersListVC: UsersListViewDelegate {
    
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

// MARK:- Rx Setup
private extension UsersListVC {
    func setupUsersObserver() {
        userListViewModel.usersList.asObservable().subscribe(onNext: {
            [unowned self] _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }).disposed(by: disposeBag)
    }
    
    func setupCellConfiguration() {
      userListViewModel.usersList
        .bind(to: tableView
          .rx
          .items(cellIdentifier: UserCell.Identifier,
                 cellType: UserCell.self)) {
                  row, user, cell in
                  cell.configureWithUser(user: user)
        }
        .disposed(by: disposeBag)
    }

    func setupCellTapHandling() {
      tableView
        .rx
        .modelSelected(UsersListItem.self)
        .subscribe(onNext: { [unowned self] user in
          if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
            self.userListViewModel.userSelected(selectedRowIndexPath.row)
            self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
          }
        })
        .disposed(by: disposeBag)
    }
    
}
