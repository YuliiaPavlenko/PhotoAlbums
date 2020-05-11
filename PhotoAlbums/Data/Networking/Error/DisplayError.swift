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
    case users, albums, photos, photo, noUser

    func displayMessage(apiError: ApiError?) -> DisplayErrorModel {
        switch self {
        case .users:
            return getErrorMessageForUsersList(apiError: apiError!)
        case .albums:
            return getErrorMessageForAlbums(apiError: apiError!)
        case .photos:
            return getErrorMessageForPhotos(apiError: apiError!)
        case .photo:
            return getErrorMessageForPhoto()
        case .noUser:
            return noUserErrorMessage()
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
    
    private func getErrorMessageForPhoto() -> DisplayErrorModel {
        let errorDescription = "Error get photo"
        let message = "Failed to find photo"
        return DisplayErrorModel(title: errorDescription, message: message)
    }
    
    private func noUserErrorMessage() -> DisplayErrorModel {
        let errorDescription = "Error get user"
        let message = "Failed to find data for selected user"
        return DisplayErrorModel(title: errorDescription, message: message)
    }
}
