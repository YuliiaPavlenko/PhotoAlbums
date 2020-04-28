//
//  UserCell.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    static let Identifier = "UserCell"

    let userNameLabel = ViewElements.createUserNameLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        configureConstraints()
    }

    fileprivate func addSubviews() {
        addSubview(userNameLabel)
    }
    
    fileprivate func configureConstraints() {
        userNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 12, paddingLeft: 26, paddingBottom: 12, paddingRight: 26, width: 40, height: 0, enableInsets: false)
    }
    
    func configureWithUser(user: UsersListItem) {
        userNameLabel.text = user.name ?? "Empty name"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
