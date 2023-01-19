//
//  DescriptionPhotoPresenter.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

class DescriptionPhotoPresenter: DescriptionPhotoPresenterProtocol {
    weak var view: DescriptionPhotoViewInput?
    var photo: Photo?
    var fromLikePhoto = false
    var isLike = false

    func viewDidLoad() {
        guard let photo = photo else { return }
        view?.configure(photo: photo)
        uploadImage()
        checkLikes()
    }

    func setupDate(photo: Photo) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: photo.createDate) ?? Date()
        let convertDate = DateFormatter()
        convertDate.dateFormat = "dd MMMM yyyy hh:mm"
        convertDate.locale = Locale(identifier: "en_EN")
        let finalDate = convertDate.string(from: date)
        return finalDate
    }

    func checkLikeButton(isLiked: Bool) {
        guard let photo = photo else { return }
        if isLiked {
            let photoData = PhotoStorage.shared.loadNotes()
            if !photoData.contains(where: { $0.id == photo.id }) {
                PhotoStorage.shared.appendPhoto([photo])
                view?.passPhotoData(photo: photo)
            }
        } else {
            view?.deletePhotoData(photo: photo)
        }
    }

    func checkLikes() {
        let photoData = PhotoStorage.shared.loadNotes()
        photoData.contains(where: { $0.id == photo?.id }) ? (isLike = true) : (isLike = false)
        view?.setLike(isLiked: isLike)
    }

    func changeButton() {
        isLike.toggle()
        view?.setLike(isLiked: isLike)
    }

    private func uploadImage() {
        NetworkManager().downloadImage(url: photo?.fullPhoto ?? "") { [weak self] image in
            guard let self = self else { return }
            self.view?.setImage(image: image)
        }
    }
}
