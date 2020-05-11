//
//  AlbumsListPresenter.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 03/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol AlbumsListViewDelegate: class {
    func showAlbums(_ albumsWithPhotos: [AlbumHolder])
    func showDownloadUserAlbumsDataError(withMessage: DisplayErrorModel)
    func showDownloadPhotosDataError(withMessage: DisplayErrorModel)
    func showAlbumsError()
    func showImage()
    func showProgress()
    func hideProgress()
}


class AlbumsListPresenter {
    
    var photos = [Photo]()
    var albumsWithPhotos = [AlbumHolder]()
    
    weak var viewDelegate: AlbumsListViewDelegate?
    
    func viewIsPrepared() {
        viewDelegate?.showProgress()
        getAlbumsList()
    }
    
    func onRefreshSwiped() {
        getAlbumsList()
    }
    
    func photoSelected(_ albumIndex: Int, _ atIndex: Int) {
        let photoId = albumsWithPhotos[albumIndex].photos![atIndex].id
        
        let selectedPhoto = photos.filter {$0.id == photoId}
        
        Cache.shared.setSelectedPhoto(selectedPhoto[0])
        viewDelegate?.showImage()
    }
    
    // MARK: - Get data from server
    fileprivate func getAlbumsList() {
        let selectedUser = Cache.shared.getSelectedUser()
        
        if let user = selectedUser {
            viewDelegate?.showProgress()
            NetworkManager.shared.getAlbumsForUser(userId: user.id) { [weak self] (albums, error) in
                guard let self = self else { return }
                self.viewDelegate?.hideProgress()
                
                if let albums = albums {                    
                    
                    // sciagnij zdjecia
                    NetworkManager.shared.getPhotos() { [weak self] (photos, error) in
                        guard let self = self else { return }
                        
                        if let photos = photos {
                            for photo in photos {
                                self.photos.append(photo)
                            }
                            
                            for album in albums {

                                // find photos for this album
                                let photosForAlbum = self.photos.filter { $0.albumID == album.id }
                                
                                var photoItems = [PhotoItem]()
                                for photo in photosForAlbum {
                                    let photo = PhotoItem(id: photo.id, photoName: photo.title, photo: photo.thumbnailURL)
                                    photoItems.append(photo)
                                }
                                
                                let newAlbum = AlbumItem(albumTitle: album.title)
                                let albumHolder = AlbumHolder(album: newAlbum, photos: photoItems)
                                self.albumsWithPhotos.append(albumHolder)
                                
                            }
                            self.viewDelegate?.showAlbums(self.albumsWithPhotos)
                            
                        } else {
                            if let error = error {
                                self.viewDelegate?.showDownloadPhotosDataError(withMessage: DisplayError.albums.displayMessage(apiError: error))
                            }
                        }
                    }
                } else {
                    if let error = error {
                        self.viewDelegate?.showDownloadUserAlbumsDataError(withMessage: DisplayError.photos.displayMessage(apiError: error))
                    }
                }
            }
        } else {
            viewDelegate?.showAlbumsError()
        }
    }
}
