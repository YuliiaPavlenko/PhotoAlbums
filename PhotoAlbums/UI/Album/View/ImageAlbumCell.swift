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
        albumImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        albumImageNameLabel.anchor(top: topAnchor, left: albumImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 12, paddingRight: 25, width: frame.size.width * 0.7, height: 0, enableInsets: false)
    }
}
