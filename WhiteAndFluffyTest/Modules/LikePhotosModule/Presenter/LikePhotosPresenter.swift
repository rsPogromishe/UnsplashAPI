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
        photoData = PhotoStorage().loadNotes()
        checkLikePhotos()
        view?.reloadData()
    }

    func passPhotoData(photo: Photo) {
        self.photoData.removeAll(where: { $0.id == photo.id })
        photoData.append(photo)
        PhotoStorage().saveNotes(photoData)
        view?.reloadData()
    }

    func deletePhotoData(photo: Photo) {
        self.photoData.removeAll(where: { $0.id == photo.id })
        PhotoStorage().saveNotes(photoData)
        view?.reloadData()
    }

    private func checkLikePhotos() {
        if photoData.isEmpty {
            view?.showAlert(bool: true)
        } else {
            view?.showAlert(bool: false)
        }
    }
}
