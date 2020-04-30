//
//  DisplayError.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 29/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct DisplayErrorModel {
    var title: String
    var message: String
}

enum DisplayError {
    case users, albums

    func displayMessage(apiError: ApiError) -> DisplayErrorModel {
        switch self {
        case .users:
            return getErrorMessageForUsersList(apiError: apiError)
        case .albums:
            return getErrorMessageGetAlbums(apiError: apiError)
        }
    }

    private func getErrorMessageForUsersList(apiError: ApiError) -> DisplayErrorModel {
        let errorDescription = "Error get users list"
        var message: String?
        switch apiError {
        case .serverError, .unknown, .communicationError:
            message = "Failed to download users list. Please make sure you\'re connected to the internet and try again.\nContact support if the problem continues."
        default:
            message = "Unknown error"
        }
        #if DEBUG
            message = apiError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }

    private func getErrorMessageGetAlbums(apiError: ApiError) -> DisplayErrorModel {
        let errorDescription = "Error get albums"
        var message: String?
        switch apiError {
        case .serverError, .unknown, .communicationError:
            message = "Failed to download albums. Please make sure you\'re connected to the internet and try again.\nContact support if the problem continues."
        default:
            message = "Unknown error"
        }
        #if DEBUG
        message = apiError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }
}
