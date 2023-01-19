//
//  CollectionPhotosPresenterProtocol.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import Foundation

protocol CollectionPhotosPresenterProtocol {
    func viewDidLoad()
    func searchPhotos(searchText: String)
    func showRandomPhotos()
}
