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

class NetworkManager {
    func fetchData(
        onCompletion: @escaping ((Photo) -> Void),
        onError: @escaping ((NetworkError) -> Void)
    ) {
        guard let url = createURLcomponents() else {
            onError(.failedURL)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    if let note = try self.parseJSON(withData: data) {
                        onCompletion(note)
                    }
                } catch {
                    onError(.parsingError)
                }
            } else {
                onError(.emptyData)
            }
        }.resume()
    }

    private func createURLcomponents() -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/photos/random/"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constant.keyAPI)
        ]

        return urlComponents.url
    }

    private func parseJSON(withData data: Data) throws -> Photo? {
        let decoder = JSONDecoder()
        let photoData = try decoder.decode(PhotoData.self, from: data)
        guard let currentWeather = Photo(photoData: photoData) else { return nil }
        return currentWeather
    }
}