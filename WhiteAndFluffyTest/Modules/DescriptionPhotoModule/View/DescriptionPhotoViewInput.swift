//
//  DescriptionPhotoViewInput.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import UIKit

protocol DescriptionPhotoViewInput: AnyObject {
    func configure(photo: Photo)
    func setImage(image: UIImage)
    func setLike(isLiked: Bool)
    func passPhotoData(photo: Photo)
    func deletePhotoData(photo: Photo)
}
