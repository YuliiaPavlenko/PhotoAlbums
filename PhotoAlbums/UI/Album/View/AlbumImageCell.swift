//
//  AlbumImageCell.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 03/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class AlbumImageCell: UITableViewCell {
    static let Identifier = "AlbumImageCell"

    let albumImageNameLabel = ViewElements.createUserNameLabel()
    let albumImageView = ViewElements.createAlbumImage()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        configureConstraints()
    }

    fileprivate func addSubviews() {
        addSubview(albumImageNameLabel)
        addSubview(albumImageView)
    }
    
    func configureConstraints() {
        albumImageNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 12, paddingRight: 25, width: 0, height: frame.size.height * 0.65, enableInsets: false)
        albumImageView.anchor(top: topAnchor, left: albumImageNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 12, paddingRight: 25, width: 0, height: 0, enableInsets: false)
    }
    
    func configureWithUser(album: AlbumItem) {
        albumImageNameLabel.text = album.albumTitle ?? "No album name"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
