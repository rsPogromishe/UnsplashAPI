//
//  DescriptionPhotoPresenterProtocol.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

protocol DescriptionPhotoPresenterProtocol {
    func viewDidLoad()
    func setupDate(photo: Photo) -> String
}
