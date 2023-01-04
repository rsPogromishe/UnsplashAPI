//
//  DescriptionPhotoAssemble.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import UIKit

class DescriptionPhotoAssemble {
    static func assembleDescriptionPhoto(
        photo: Photo,
        fromLikePhoto: Bool,
        delegate: DescriptionPhotoViewControllerDelegate
    ) -> UIViewController {
        let presenter = DescriptionPhotoPresenter()
        let view = DescriptionPhotoViewController(presenter: presenter)
        view.presenter = presenter
        view.delegate = delegate
        presenter.view = view
        presenter.photo = photo
        presenter.fromLikePhoto = fromLikePhoto
        return view
    }
}
