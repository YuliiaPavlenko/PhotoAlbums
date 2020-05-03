//
//  ImageAlbumCell.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 03/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class ImageAlbumCell: AlbumImageCell {
    static let Id = "ImageAlbumCell"
    
    override func configureConstraints() {
        albumImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 12, paddingRight: 25, width: 0, height: 0, enableInsets: false)
        albumImageNameLabel.anchor(top: topAnchor, left: albumImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 12, paddingRight: 25, width: 0, height: frame.size.height * 0.65, enableInsets: false)
    }
}
