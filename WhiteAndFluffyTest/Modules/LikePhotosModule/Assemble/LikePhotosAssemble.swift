//
//  LikePhotosAssemble.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import UIKit

class LikePhotosAssemble {
    static func assembleLikePhotosModule() -> UIViewController {
        let presenter = LikePhotosPresenter()
        let view = LikePhotoViewController(presenter: presenter)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
