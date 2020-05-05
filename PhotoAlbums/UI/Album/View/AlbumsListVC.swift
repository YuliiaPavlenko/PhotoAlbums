//
//  AlbumsListVC.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 03/05/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import PKHUD

class AlbumsListVC: UIViewController {
    
    let tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var albumListPresenter = AlbumsListPresenter()
    var albumsList = [AlbumItem]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        albumListPresenter.viewDelegate = self
        view.backgroundColor = .white
        customizeNavigationBar()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        albumListPresenter.viewIsPrepared()
        customizeNavigationBar(animated)
    }

    // MARK: - Custom Functions
    func customizeNavigationBar(_ animated: Bool) {
        title = "Albums"
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        configureConstraintsForTableView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumImageCell.self, forCellReuseIdentifier: AlbumImageCell.Identifier)
        tableView.register(ImageAlbumCell.self, forCellReuseIdentifier: ImageAlbumCell.Id)
        
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        albumListPresenter.onRefreshSwiped()
    }

    func configureConstraintsForTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    private func customizeNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}


// MARK: - UITableView Delegate & DataSource
extension AlbumsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO
        return albumsList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return albumsList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return albumsList[section].albumTitle?.capitalized
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO
        let currentAlbum = albumsList[indexPath.row]
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumImageCell.Identifier, for: indexPath) as! AlbumImageCell
            cell.configureWithAlbum(album: currentAlbum)
            return cell
        } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: ImageAlbumCell.Id, for: indexPath) as! ImageAlbumCell
            cell.configureWithAlbum(album: currentAlbum)
            return cell
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumImageCell.Identifier, for: indexPath) as! AlbumImageCell
        
        
//        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        albumListPresenter.showImage(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AlbumsListVC: AlbumsListViewDelegate {
    func showAlbums(_ albums: [AlbumItem]) {
        albumsList = albums
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlbumsError() {
        let alert = CustomErrorAlert.setUpErrorAlert(nil)
        present(alert, animated: true)
    }
    
    func showImage() {
        
    }
    
    func showDownloadUserAlbumsDataError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
    
    func showUserAlbums() {
        let albumsListVC = AlbumsListVC()
        navigationController?.pushViewController(albumsListVC, animated: false)
    }
    
    func showProgress() {
        HUD.show(.progress)
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            HUD.hide()
        }
    }
}
