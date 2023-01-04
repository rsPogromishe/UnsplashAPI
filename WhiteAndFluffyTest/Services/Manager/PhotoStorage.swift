//
//  PhotoStorage.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

class PhotoStorage {
    private let storage = UserDefaults.standard
    private let storageKey: String = "photos"

    private enum PhotoKey: String {
        case id
        case authorName
        case downloads
        case createDate
        case location
        case smallPhoto
        case fullPhoto
    }

    func loadNotes() -> [Photo] {
        var resultPhotos: [Photo] = []
        let photosFromStorage = storage.array(forKey: storageKey) as? [[String: Any]] ?? []
        for photo in photosFromStorage {
            guard let authorName = photo[PhotoKey.authorName.rawValue] as? String,
                  let downloads = photo[PhotoKey.downloads.rawValue] as? Int,
                  let createDate = photo[PhotoKey.createDate.rawValue] as? String,
                  let location = photo[PhotoKey.location.rawValue] as? String,
                  let smallPhoto = photo[PhotoKey.smallPhoto.rawValue] as? String,
                  let fullPhoto = photo[PhotoKey.fullPhoto.rawValue] as? String,
                  let id = photo[PhotoKey.id.rawValue] as? String
            else { continue }
            resultPhotos.append(
                Photo(
                    authorName: authorName,
                    createDate: createDate,
                    downloads: downloads,
                    location: location,
                    smallPhoto: smallPhoto,
                    fullPhoto: fullPhoto,
                    id: id
                )
            )
        }
        return resultPhotos
    }

    func saveNotes(_ photos: [Photo]) {
        var arrayForStorage: [[String: Any]] = []
        photos.forEach { photo in
            var newElementForStorage: [String: Any] = [:]
            newElementForStorage[PhotoKey.authorName.rawValue] = photo.authorName
            newElementForStorage[PhotoKey.downloads.rawValue] = photo.downloads
            newElementForStorage[PhotoKey.createDate.rawValue] = photo.createDate
            newElementForStorage[PhotoKey.location.rawValue] = photo.location
            newElementForStorage[PhotoKey.smallPhoto.rawValue] = photo.smallPhoto
            newElementForStorage[PhotoKey.fullPhoto.rawValue] = photo.fullPhoto
            newElementForStorage[PhotoKey.id.rawValue] = photo.id
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }

    func appendPhoto(_ photos: [Photo]) {
        var photosFromStorage = storage.array(forKey: storageKey) as? [[String: Any]] ?? []
        photos.forEach { photo in
            var newElementForStorage: [String: Any] = [:]
            newElementForStorage[PhotoKey.authorName.rawValue] = photo.authorName
            newElementForStorage[PhotoKey.downloads.rawValue] = photo.downloads
            newElementForStorage[PhotoKey.createDate.rawValue] = photo.createDate
            newElementForStorage[PhotoKey.location.rawValue] = photo.location
            newElementForStorage[PhotoKey.smallPhoto.rawValue] = photo.smallPhoto
            newElementForStorage[PhotoKey.fullPhoto.rawValue] = photo.fullPhoto
            newElementForStorage[PhotoKey.id.rawValue] = photo.id
            photosFromStorage.append(newElementForStorage)
        }
        storage.set(photosFromStorage, forKey: storageKey)
    }
}
