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

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}


extension PhotoVC: PhotoViewDelegate {
    func showImage(_ image: [ImageItem]) {
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func showDownloadPhotoError(withMessage: DisplayErrorModel) {
        
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
