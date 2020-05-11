//
//  Cache.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 03/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class Cache {
    static let shared = Cache()

    private var selectedUser: User?
    private var selectedPhoto: Photo?

    private init() {
    }

    func setSelectedUser(_ user: User) {
        selectedUser = user
    }

    func getSelectedUser() -> User? {
        return selectedUser
    }
    
    func setSelectedPhoto(_ photo: Photo) {
        selectedPhoto = photo
    }
    
    func getSelectedPhoto() -> Photo? {
        return selectedPhoto
    }
}
