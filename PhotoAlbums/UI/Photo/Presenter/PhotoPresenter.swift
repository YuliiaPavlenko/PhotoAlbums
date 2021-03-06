//
//  PhotoPresenter.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 10/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol PhotoViewDelegate: class {
    func showImageFromURL(_ url: String)
    func showLoadPhotoError(withMessage: DisplayErrorModel)
    func showProgress()
    func hideProgress()
}

class PhotoPresenter {
    
    weak var viewDelegate: PhotoViewDelegate?
    var navBarTitle: String?
    
    func showPhoto() {
        let selectedPhoto = Cache.shared.getSelectedPhoto()
        
        if let photo = selectedPhoto {
            let photoToShow = ImageItem(url: photo.url, title: photo.title)
            if let url = photoToShow.url {
                viewDelegate?.showImageFromURL(url)
            } else {
                viewDelegate?.showLoadPhotoError(withMessage: DisplayError.photo.displayMessage(apiError: nil))
            }
            navBarTitle = photoToShow.title
        } else {
            viewDelegate?.showLoadPhotoError(withMessage: DisplayError.photo.displayMessage(apiError: nil))
        }
    }
    
    func setNavigationBarTitle() -> String {
        return navBarTitle ?? "No image name"
    }
    
    func startLoadingPhoto() {
        viewDelegate?.showProgress()
    }
    
    func finishLoadingPhoto() {
        viewDelegate?.hideProgress()
    }
}
