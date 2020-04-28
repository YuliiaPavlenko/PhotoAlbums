//
//  Router.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class Router {
    static let photos = Config.baseURL + "/photos"
    static let albums = Config.baseURL + "/albums"
    static let users = Config.baseURL + "/users"
    
    static func albumsForUser(_ id: Int) -> String {
        return albums + "?userId=\(id)"
    }
    
    static func photosForAlbum(_ id: Int) -> String {
        return photos + "?albumId=\(id)"
    }
}
