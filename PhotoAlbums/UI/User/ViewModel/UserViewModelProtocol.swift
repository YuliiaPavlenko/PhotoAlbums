//
//  UserViewModelProtocol.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 07/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserViewModelProtocol {
    
    var usersList: BehaviorRelay<[UsersListItem]> {get}

//    var webService: NetworkManagerProtocol {get}
    
//    init(webService: NetworkManagerProtocol)
//    init()
    
    func viewIsPrepared()
    func onRefreshSwiped()
    func userSelected(_ atIndex: Int)
}
