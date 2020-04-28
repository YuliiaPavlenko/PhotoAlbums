//
//  ErrorInfo.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct ErrorInfo {
    var httpCode: Int?
    var errorDescription: String?
    var message: String?

    var debugInfo: String {
        return "Http code: \(String(describing: httpCode)), Description: \(errorDescription ?? ""), Message: \(message ?? "")"
    }
}
