//
//  LikePhotosPresenter.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

class LikePhotosPresenter: LikePhotosPresenterProtocol {
    weak var view: LikePhotosViewInput?

    var photoData: [Photo] = []

    func viewWillAppear() {
        photoData = PhotoStorage.shared.loadNotes()
        checkLikePhotos()
        view?.reloadData()
    }

    func passPhotoData(photo: Photo) {
        self.photoData.removeAll(where: { $0.id == photo.id })
        photoData.append(photo)
        PhotoStorage.shared.saveNotes(photoData)
        view?.reloadData()
    }

    func deletePhotoData(photo: Photo) {
        self.photoData.removeAll(where: { $0.id == photo.id })
        PhotoStorage.shared.saveNotes(photoData)
        view?.reloadData()
    }

    private func checkLikePhotos() {
        if photoData.isEmpty {
            view?.showAlert(isEmpty: true)
        } else {
            view?.showAlert(isEmpty: false)
        }
    }
}
