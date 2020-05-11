//
//  PhotoPresenter.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 10/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol PhotoViewDelegate: class {
    func showImage(_ image: ImageItem)
    func showPhotoError()
    func showDownloadPhotoError(withMessage: DisplayErrorModel)
}


class PhotoPresenter {
    
    weak var viewDelegate: PhotoViewDelegate?
    var navBarTitle: String?
    
    func showPhoto() {
        let selectedPhoto = Cache.shared.getSelectedPhoto()
        
        if let photo = selectedPhoto {
            let photoToShow = ImageItem(url: photo.url, title: photo.title)
            viewDelegate?.showImage(photoToShow)
            navBarTitle = photo.title
        } else {
            viewDelegate?.showPhotoError()
        }
    }
    
    func setNavigationBarTitle() -> String {
        return navBarTitle ?? "No image name"
    }
}
