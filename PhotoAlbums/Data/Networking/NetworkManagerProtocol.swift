//
//  NetworkManagerProtocol.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 07/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func getUsers(completion: @escaping (([User]?, ApiError?) -> Void))
    func getAlbumsForUser(userId: Int, completion: @escaping (([Album]?, ApiError?) -> Void))
    func getPhotos(completion: @escaping (([Photo]?, ApiError?) -> Void))
}
