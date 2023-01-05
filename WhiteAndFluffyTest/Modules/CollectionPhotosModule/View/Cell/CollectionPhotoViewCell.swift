//
//  CollectionPhotoViewCell.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 03.09.2022.
//

import UIKit

class CollectionPhotoViewCell: UICollectionViewCell {
    static let identifier = "collectionPhotoViewCell"

    private let picture = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFill
        picture.translatesAutoresizingMaskIntoConstraints = false
        addSubview(picture)

        NSLayoutConstraint.activate([
            picture.rightAnchor.constraint(equalTo: rightAnchor),
            picture.leftAnchor.constraint(equalTo: leftAnchor),
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(photo: Photo) {
        NetworkManager().uploadImage(url: photo.smallPhoto) { image in
            self.picture.image = image
        }
    }
}
