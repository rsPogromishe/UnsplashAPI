//
//  NetworkManager.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import Foundation

enum NetworkError {
    case failedURL
    case parsingError
    case emptyData
}

enum RequestType {
    case random
    case search(searchTerms: String)
}

class NetworkManager {
    func fetchData(
        requestType: RequestType,
        onCompletion: @escaping (([Photo]) -> Void),
        onError: @escaping ((NetworkError) -> Void)
    ) {
        guard let url = createURLcomponents(requestType: requestType) else {
            onError(.failedURL)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    switch requestType {
                    case .random:
                        if let note = try self.randomPhotoParseJSON(withData: data) {
                            onCompletion(note)
                        }
                    case .search:
                        if let note = try self.searchPhotoParseJSON(withData: data) {
                            onCompletion(note)
                        }
                    }
                    
                } catch {
                    onError(.parsingError)
                    print(error)
                }
            } else {
                onError(.emptyData)
            }
        }.resume()
    }

    private func createURLcomponents(requestType: RequestType) -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        switch requestType {
        case .random:
            urlComponents.path = "/photos/random/"
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: Constant.keyAPI),
                URLQueryItem(name: "count", value: "12")
            ]
        case .search(let searchTerms):
            urlComponents.path = "/search/photos/"
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: Constant.keyAPI),
                URLQueryItem(name: "query", value: searchTerms)
            ]
        }
        return urlComponents.url
    }

    private func randomPhotoParseJSON(withData data: Data) throws -> [Photo]? {
        let decoder = JSONDecoder()
        let photoData = try decoder.decode([PhotoData].self, from: data)
        var photos: [Photo] = []
        for datum in photoData {
            guard let photo = Photo(photoData: datum) else { return nil }
            photos.append(photo)
        }
        return photos
    }

    private func searchPhotoParseJSON(withData data: Data) throws -> [Photo]? {
        let decoder = JSONDecoder()
        let photoData = try decoder.decode(SearchData.self, from: data)
        var photos: [Photo] = []
        guard let searchData = photoData.results else { return nil }
        for datum in searchData {
            guard let photo = Photo(searchData: datum) else { return nil }
            photos.append(photo)
        }
        return photos
    }
}
