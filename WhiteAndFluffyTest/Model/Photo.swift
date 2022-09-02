//
//  Photo.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import Foundation

struct Photo: Codable {
    let authorName: String
    let createDate: String
    let downloads: Int
    let location: String
    let smallPhoto: String
    let fullPhoto: String

    init?(photoData: PhotoData) {
        authorName = photoData.user?.name ?? ""
        createDate = photoData.createDate ?? ""
        downloads = photoData.downloads ?? 1
        location = photoData.location?.name ?? ""
        smallPhoto = photoData.urls?.small ?? ""
        fullPhoto = photoData.urls?.full ?? ""
    }
}
