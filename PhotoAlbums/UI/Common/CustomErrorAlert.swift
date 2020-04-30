//
//  CustomErrorAlert.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 30/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CustomErrorAlert {

    static func setUpErrorAlert(_ withMessage: DisplayErrorModel?) -> UIAlertController {
        let errorTitle = withMessage?.title
        let alert = UIAlertController(title: errorTitle, message: withMessage?.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction!) in
        }))
        return alert
    }
}
