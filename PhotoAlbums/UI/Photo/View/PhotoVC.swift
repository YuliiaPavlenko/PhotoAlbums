//
//  PhotoVC.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 10/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import WebKit

class PhotoVC: UIViewController, WKNavigationDelegate {

    var photoPresenter = PhotoPresenter()
    var webView: WKWebView!
    
    // MARK: - View Lifecycle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPresenter.viewDelegate = self
        photoPresenter.showPhoto()
    }
    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar(animated)
    }
    
    // MARK: - Custom Function
    func customizeNavigationBar(_ animated: Bool) {
        title = photoPresenter.setNavigationBarTitle()
    }
}


extension PhotoVC: PhotoViewDelegate {
    func showImage(_ image: ImageItem) {
        let url = URL(string: image.url!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func showPhotoError() {
        let alert = CustomErrorAlert.setUpErrorAlert(nil)
        present(alert, animated: true)
    }
    
    func showDownloadPhotoError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
}
