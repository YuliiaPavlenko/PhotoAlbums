//
//  User.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let name, username, email: String
    let phone, website: String
}
