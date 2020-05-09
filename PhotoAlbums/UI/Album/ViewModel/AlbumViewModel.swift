//
//  AlbumViewModel.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 08/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AlbumsListViewDelegate: class {
    func showDownloadUserAlbumsDataError(withMessage: DisplayErrorModel)
    func showDownloadPhotosDataError(withMessage: DisplayErrorModel)
    func showAlbumsError()
    func showImage()
    func showProgress()
    func hideProgress()
}

class AlbumViewModel {
    
    // MARK: - RxSwift Properties
    var albumsList: BehaviorRelay<[AlbumItem]> = BehaviorRelay(value: [])
    var photosList: BehaviorRelay<[PhotoItem]> = BehaviorRelay(value: [])
    
    var photos = [Photo]()
    
    weak var viewDelegate: AlbumsListViewDelegate?
    
    func viewIsPrepared() {
        viewDelegate?.showProgress()
        getAlbumsList()
    }
    
    func onRefreshSwiped() {
        getAlbumsList()
    }
    
    // MARK: - Get data from server
    fileprivate func getPhotosForAlbum(albums: [Album]) {
        // sciagnij zdjecia
        NetworkManager.shared.getPhotos() { [weak self] (photos, error) in
            guard let self = self else { return }
            self.viewDelegate?.hideProgress()
            if let photos = photos {
                for photo in photos {
                    self.photos.append(photo)
                }
                
                for album in albums {
                    let aalbum = AlbumItem(albumTitle: album.title)
                    let newAlbum = self.albumsList.value + [aalbum]
                    self.albumsList.accept(newAlbum)
                    
                    // find photos for this album
                    let photosForAlbum = self.photos.filter { $0.albumID == album.id }
                    
                    for photo in photosForAlbum {
                        let photo = PhotoItem(photoName: photo.title, photo: photo.thumbnailURL)
                        let newPhoto = self.photosList.value + [photo]
                        self.photosList.accept(newPhoto)
                    }
                    
                }
                
            } else {
                if let error = error {
                    // add error for photos
                    self.viewDelegate?.showDownloadPhotosDataError(withMessage: DisplayError.albums.displayMessage(apiError: error))
                }
            }
        }
    }
    
    fileprivate func getAlbumsList() {
        let selectedUser = Cache.shared.getSelectedUser()
        
        if let user = selectedUser {
            viewDelegate?.showProgress()
            NetworkManager.shared.getAlbumsForUser(userId: user.id) { [weak self] (albums, error) in
                guard let self = self else { return }
//                self.viewDelegate?.hideProgress()
                switch (albums, error) {
                case (let albums?, nil):
                    self.getPhotosForAlbum(albums: albums)
                case (_, .some(let error)):
                    self.viewDelegate?.showDownloadUserAlbumsDataError(withMessage: DisplayError.albums.displayMessage(apiError: error))
                case (.none, .none):
                    print("Defult case")
                }
            }
        } else {
            viewDelegate?.showAlbumsError()
        }
    }
}
