//
//  PhotoData.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import Foundation

struct PhotoData: Codable {
    let createDate: String?
    let urls: Urls?
    let user: User?
    let location: Location?
    let downloads: Int?

    enum CodingKeys: String, CodingKey {
        case user
        case downloads
        case location
        case createDate = "created_at"
        case urls
    }
}

struct Urls: Codable {
    let full: String?
    let small: String?
}

struct User: Codable {
    let name: String?
}

struct Location: Codable {
    let name: String?
}

