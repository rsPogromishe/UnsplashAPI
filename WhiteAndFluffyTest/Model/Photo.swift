//
//  Photo.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import Foundation

struct Photo: Codable {
    let id: String
    let authorName: String
    let createDate: String
    let downloads: Int
    let location: String
    let smallPhoto: String
    let fullPhoto: String

    init?(photoData: PhotoData) {
        id = photoData.id ?? ""
        authorName = photoData.user?.name ?? ""
        createDate = photoData.createDate ?? ""
        downloads = photoData.downloads ?? 1
        location = photoData.location?.name ?? ""
        smallPhoto = photoData.urls?.thumb ?? ""
        fullPhoto = photoData.urls?.full ?? ""
    }

    init?(searchData: Results) {
        id = searchData.id ?? ""
        authorName = searchData.user?.name ?? ""
        createDate = searchData.createDate ?? ""
        smallPhoto = searchData.urls?.thumb ?? ""
        fullPhoto = searchData.urls?.full ?? ""
        downloads = 0
        location = ""
    }

    init(
        authorName: String,
        createDate: String,
        downloads: Int,
        location: String,
        smallPhoto: String,
        fullPhoto: String,
        id: String
    ) {
        self.id = id
        self.authorName = authorName
        self.createDate = createDate
        self.downloads = downloads
        self.location = location
        self.smallPhoto = smallPhoto
        self.fullPhoto = fullPhoto
    }
}
