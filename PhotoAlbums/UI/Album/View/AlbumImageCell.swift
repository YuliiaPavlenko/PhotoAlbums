//
//  AlbumImageCell.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 03/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumImageCell: UITableViewCell {
    
    class var Identifier: String { "AlbumImageCell" }
    
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
        albumImageNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 12, paddingLeft: 25, paddingBottom: 12, paddingRight: 0, width: frame.size.width * 0.7, height: 0, enableInsets: false)
        albumImageView.anchor(top: topAnchor, left: albumImageNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 12, paddingRight: 25, width: 0, height: 0, enableInsets: false)
    }
    
    func configureWithAlbum(photo: PhotoItem) {
        albumImageNameLabel.text = photo.photoName ?? "No album name"
        if photo.photo != nil {
            let url = URL(string: photo.photo!)
            albumImageView.kf.setImage(with: url)
        } else {
            albumImageView.image = UIImage(named: "noImageIcon.png")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
