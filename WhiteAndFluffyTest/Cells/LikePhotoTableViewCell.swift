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
        image.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.font = .systemFont(ofSize: 24)

        addSubview(image)
        addSubview(authorNameLabel)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),

            authorNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            authorNameLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 40)
        ])
    }

    func configure() {
    }
}
