//
//  UserViewModel.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 07/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UsersListViewDelegate: class {
    func showDownloadUserAlbumsDataError(withMessage: DisplayErrorModel)
    func showUserAlbums()
    func showProgress()
    func hideProgress()
}

class UserViewModel: UserViewModelProtocol {
    
    // MARK: - RxSwift Properties
    var usersList: BehaviorRelay<[UsersListItem]> = BehaviorRelay(value: [])
    
    var originalUsersList = [User]()
    
    weak var viewDelegate: UsersListViewDelegate?
    
    // WebService
    
//    var webService: NetworkManagerProtocol
    
    // Initializer

//    required init(webService: NetworkManagerProtocol) {
//        self.webService = webService
//    }
    
//    required init() {  }
    
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
        usersList.accept([])
        
        NetworkManager.shared.getUsers { [weak self] (users, error) in
            guard let self = self else { return }
            
            self.viewDelegate?.hideProgress()
            
            switch (users, error) {
            case (let users?, nil):
                self.originalUsersList = users
                
                for user in users {
                    let user = UsersListItem(name: user.name)
                    let newUser = self.usersList.value + [user]
                    self.usersList.accept(newUser)
                }
            case (_, .some(let error)):
                self.viewDelegate?.showDownloadUserAlbumsDataError(withMessage: DisplayError.users.displayMessage(apiError: error))
            case (.none, .none):
                print("Defult case")
            }
        }
    }
}
