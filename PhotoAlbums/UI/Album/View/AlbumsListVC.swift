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
    var holder = [AlbumHolder]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        albumListPresenter.viewDelegate = self
        customizeNavigationBar(true)
        albumListPresenter.viewIsPrepared()
        setupTableView()
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
        tableView.register(ImageAlbumCell.self, forCellReuseIdentifier: ImageAlbumCell.Identifier)
        
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
}


// MARK: - UITableView Delegate & DataSource
extension AlbumsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holder[section].photos!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return holder.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return holder[section].album?.albumTitle?.capitalized
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentPhoto = holder[indexPath.section].photos![indexPath.row]
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumImageCell.Identifier, for: indexPath) as! AlbumImageCell
            cell.configureWithAlbum(photo: currentPhoto)
            return cell
        } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: ImageAlbumCell.Identifier, for: indexPath) as! ImageAlbumCell
            cell.configureWithAlbum(photo: currentPhoto)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albumListPresenter.photoSelected(indexPath.section, indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AlbumsListVC: AlbumsListViewDelegate {
    func showAlbums(_ albumsWithPhotos: [AlbumHolder]) {
        holder = albumsWithPhotos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlbumsError(withMessage: DisplayErrorModel) {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
        present(alert, animated: true)
    }
    
    func showImage() {
        let photoVC = PhotoVC()
        navigationController?.pushViewController(photoVC, animated: false)
    }
    
    func showDownloadAlbumsDataError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
    
    func showDownloadPhotosDataError(withMessage: DisplayErrorModel) {
        DispatchQueue.main.async {
        let alert = CustomErrorAlert.setUpErrorAlert(withMessage)
            self.present(alert, animated: true)
        }
    }
    
    func showProgress() {
        HUD.show(.progress)
        HUD.allowsInteraction = true
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            HUD.hide()
        }
    }
}
