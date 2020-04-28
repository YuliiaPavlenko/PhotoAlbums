//
//  NetworkManager.swift
//  PhotoAlbums
//
//  Created by Yuliia Pavlenko on 28/04/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()
    let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    private func getData<Data: Decodable>(url: URL, completion: @escaping ((Data?, ApiError?) -> Void)) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            if let error = validateApiResponse(response: response, error: error) {
                completion(nil, error)
                return
            }

            do {
                let json = try JSONDecoder().decode(Data.self, from: data!)

                completion(json, nil)
            } catch {
                var errorInfo = ErrorInfo()
                errorInfo.message = "Error during JSON serialization: \(error.localizedDescription)"

                completion(nil, ApiError.parsingResponseError(errorInfo: errorInfo))
            }

        })
        task.resume()
    }

    func getUsers(completion: @escaping (([User]?, ApiError?) -> Void)) {
        let url = URL(string: Router.users)!
        getData(url: url, completion: completion)
    }

    func getAlbumsForUser(userId: Int, completion: @escaping (([Album]?, ApiError?) -> Void)) {
        let url = URL(string: Router.albumsForUser(userId))!
        getData(url: url, completion: completion)
    }
    
    func getPhotosForAlbum(albumId: Int, completion: @escaping (([Photo]?, ApiError?) -> Void)) {
        let url = URL(string: Router.photosForAlbum(albumId))!
        getData(url: url, completion: completion)
    }
}
