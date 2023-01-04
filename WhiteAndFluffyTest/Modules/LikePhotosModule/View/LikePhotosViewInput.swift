//
//  LikePhotosViewInput.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

protocol LikePhotosViewInput: AnyObject {
    func reloadData()
    func showAlert(bool: Bool)
}
