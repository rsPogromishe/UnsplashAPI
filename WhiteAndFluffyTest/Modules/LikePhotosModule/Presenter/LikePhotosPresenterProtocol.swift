//
//  LikePhotosPresenterProtocol.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

protocol LikePhotosPresenterProtocol {
    func viewWillAppear()
    func passPhotoData(photo: Photo)
    func deletePhotoData(photo: Photo)
}
