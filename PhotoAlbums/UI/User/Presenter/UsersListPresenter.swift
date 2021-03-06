//
//  UsersListPresenter.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol UsersListViewDelegate: class {
    func showUsers(_ users: [UsersListItem])
    func showDownloadUserAlbumsDataError(withMessage: DisplayErrorModel)
    func showUserAlbums()
    func showProgress()
    func hideProgress()
}

class UsersListPresenter {
    var usersList = [UsersListItem]()
    var originalUsersList = [User]()
    
    weak var viewDelegate: UsersListViewDelegate?
    
    func viewIsPrepared() {
        viewDelegate?.showProgress()
        getUserList()
    }
    
    func onRefreshSwiped() {
        getUserList()
    }
    
    func userSelected(_ atIndex: Int) {
        Cache.shared.setSelectedUser(originalUsersList[atIndex])
        viewDelegate?.showUserAlbums()
    }
    
    // MARK: - Get data from server
    fileprivate func getUserList() {
        usersList = []
        
        NetworkManager.shared.getUsers { [weak self] (users, error) in
            guard let self = self else { return }
            
            self.viewDelegate?.hideProgress()
            
            switch (users, error) {
            case (let users?, nil):
                self.originalUsersList = users
                
                for user in users {
                    let user = UsersListItem(name: user.name)
                    self.usersList.append(user)
                }
                self.viewDelegate?.showUsers(self.usersList)
            case (_, .some(let error)):
                self.viewDelegate?.showDownloadUserAlbumsDataError(withMessage: DisplayError.users.displayMessage(apiError: error))
            case (.none, .none):
                print("Defult case")
            }
        }
    }
}
