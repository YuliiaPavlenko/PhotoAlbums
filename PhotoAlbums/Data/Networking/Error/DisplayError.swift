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
    case users, albums, photos, photo

    func displayMessage(apiError: ApiError) -> DisplayErrorModel {
        switch self {
        case .users:
            return getErrorMessageForUsersList(apiError: apiError)
        case .albums:
            return getErrorMessageForAlbums(apiError: apiError)
        case .photos:
            return getErrorMessageForPhotos(apiError: apiError)
        case .photo:
            return getErrorMessageForPhoto(apiError: apiError)
        }
    }

    private func getErrorMessageForUsersList(apiError: ApiError) -> DisplayErrorModel {
        let errorDescription = "Error get users list"
        var message: String?
        switch apiError {
        case .serverError, .unknown, .communicationError:
            message = "Contact support if the problem continues."
        default:
            message = "Unknown error"
        }
        #if DEBUG
            message = apiError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }

    private func getErrorMessageForAlbums(apiError: ApiError) -> DisplayErrorModel {
        let errorDescription = "Error get albums"
        var message: String?
        switch apiError {
        case .serverError, .unknown, .communicationError:
            message = "Contact support if the problem continues."
        default:
            message = "Unknown error"
        }
        #if DEBUG
        message = apiError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }
    
    private func getErrorMessageForPhotos(apiError: ApiError) -> DisplayErrorModel {
        let errorDescription = "Error get photos for albums"
        var message: String?
        switch apiError {
        case .serverError, .unknown, .communicationError:
            message = "Failed to load photos. Please make sure you\'re connected to the internet and try again."
        default:
            message = "Unknown error"
        }
        #if DEBUG
        message = apiError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }
    
    private func getErrorMessageForPhoto(apiError: ApiError) -> DisplayErrorModel {
        let errorDescription = "Error get photo"
        var message: String?
        switch apiError {
        case .serverError, .unknown, .communicationError:
            message = "Failed to load photo. Please make sure you\'re connected to the internet and try again."
        default:
            message = "Unknown error"
        }
        #if DEBUG
        message = apiError.debugDescription
        #endif
        return DisplayErrorModel(title: errorDescription, message: message!)
    }
}
