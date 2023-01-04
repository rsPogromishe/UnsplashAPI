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

    func viewDidLoad() {
        guard let photo = photo else { return }
        view?.configure(photo: photo)
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
}
