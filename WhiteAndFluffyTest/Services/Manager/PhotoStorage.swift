//
//  PhotoStorage.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

class PhotoStorage {
    static let shared = PhotoStorage()

    private let storage = UserDefaults.standard
    private let storageKey: String = "photos"

    func loadNotes() -> [Photo] {
        var resultPhotos: [Photo] = []
        if let photosFromStorage = storage.data(forKey: storageKey) {
            do {
                let photo = try JSONDecoder().decode([Photo].self, from: photosFromStorage)
                resultPhotos.append(contentsOf: photo)
            } catch {
                print(error)
            }
        }
        return resultPhotos
    }

    func saveNotes(_ photos: [Photo]) {
        do {
            let photoData = try JSONEncoder().encode(photos)
            storage.set(photoData, forKey: storageKey)
        } catch {
            print(error)
        }
    }

    func appendPhoto(_ photos: [Photo]) {
        var photosFromStorage = loadNotes()
        photosFromStorage.append(contentsOf: photos)
        saveNotes(photosFromStorage)
    }
}
