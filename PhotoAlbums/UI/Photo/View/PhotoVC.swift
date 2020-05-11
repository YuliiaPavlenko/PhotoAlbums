//
//  PhotoVC.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 10/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import WebKit
import PKHUD

class PhotoVC: UIViewController, WKNavigationDelegate {

    var photoPresenter = PhotoPresenter()
    var webView: WKWebView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPresenter.viewDelegate = self
        photoPresenter.showPhoto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar(animated)
    }
    
    // MARK: - Configure WebView
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        photoPresenter.startLoadingPhoto()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        photoPresenter.finishLoadingPhoto()
    }
    
    // MARK: - Navigation Bar
    func customizeNavigationBar(_ animated: Bool) {
        title = photoPresenter.setNavigationBarTitle()
    }
}

extension PhotoVC: PhotoViewDelegate {
    func showImageFromURL(_ url: String) {
        let url = URL(string: url)
        webView.load(URLRequest(url: url!))
    }
    
    func showLoadPhotoError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
    
    func showProgress() {
        HUD.show(.progress)
    }

    func hideProgress() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
}
