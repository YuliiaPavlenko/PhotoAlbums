//
//  AlbumsListPresenter.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 03/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol AlbumsListViewDelegate: class {
    func showAlbums(_ albums: [AlbumItem])
    func showDownloadUserAlbumsDataError(withMessage: DisplayErrorModel)
    func showAlbumsError()
    func showImage()
    func showProgress()
    func hideProgress()
}


class AlbumsListPresenter {
    var albumsList = [AlbumItem]()
    var originalUsersList = [Album]()
    
    weak var viewDelegate: AlbumsListViewDelegate?
    
    func viewIsPrepared() {
        viewDelegate?.showProgress()
        getAlbumsList()
    }
    
    func onRefreshSwiped() {
        getAlbumsList()
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
                    
                    for album in albums {
                        let album = AlbumItem(albumTitle: album.title, imageName: album.title, imageThumbnail: album.title)
                        self.albumsList.append(album)
                    }
                    self.viewDelegate?.showAlbums(self.albumsList)
                } else {
                    if let error = error {
                        self.viewDelegate?.showDownloadUserAlbumsDataError(withMessage: DisplayError.albums.displayMessage(apiError: error))
                    }
                }
            }
        } else {
            viewDelegate?.showAlbumsError()
        }
    }
}
