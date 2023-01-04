//
//  CollectionPhotosAssemble.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import UIKit

class CollectionPhotosAssemble {
    static func assembleCollectionPhotosModule() -> UIViewController {
        let presenter = CollectionPhotosPresenter()
        let view = CollectionPhotosViewController(presenter: presenter)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
