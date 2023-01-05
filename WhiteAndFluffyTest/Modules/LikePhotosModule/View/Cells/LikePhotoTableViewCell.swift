//
//  LikePhotoTableViewCell.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.09.2022.
//

import UIKit

class LikePhotoTableViewCell: UITableViewCell {
    static let identifier = "likePhotoTableViewCell"

    private let image = UIImageView()
    private let authorNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.font = .systemFont(ofSize: 24)

        addSubview(image)
        addSubview(authorNameLabel)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 100),

            authorNameLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            authorNameLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 40)
        ])
    }

    func configure(photo: Photo) {
        authorNameLabel.text = photo.authorName
        NetworkManager().downloadImage(url: photo.smallPhoto) { [weak self] image in
            guard let self = self else { return }
            self.image.image = image
        }
    }
}
