//
//  DescriptionPhotoViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.09.2022.
//

import UIKit

class DescriptionPhotoViewController: UIViewController {

    private let image = UIImageView()
    private let locationLabel = UILabel()
    private let authorNameLabel = UILabel()
    private let downloadsCountLabel = UILabel()
    private let createDateLabel = UILabel()
    private let likeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
}

//MARK: Setup UI

extension DescriptionPhotoViewController {
    private func setupUI() {
        image.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = .systemFont(ofSize: 18)
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.font = .systemFont(ofSize: 16)
        downloadsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsCountLabel.font = .systemFont(ofSize: 14)
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        createDateLabel.font = .systemFont(ofSize: 14)
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(image)
        view.addSubview(locationLabel)
        view.addSubview(authorNameLabel)
        view.addSubview(downloadsCountLabel)
        view.addSubview(createDateLabel)
        view.addSubview(likeButton)

        NSLayoutConstraint.activate([
            image.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),

            likeButton.rightAnchor.constraint(equalTo: image.leftAnchor),
            likeButton.topAnchor.constraint(equalTo: image.bottomAnchor),

            locationLabel.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),

            authorNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),

            downloadsCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadsCountLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 20),

            createDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createDateLabel.topAnchor.constraint(equalTo: downloadsCountLabel.bottomAnchor, constant: 10)
        ])
    }
}
