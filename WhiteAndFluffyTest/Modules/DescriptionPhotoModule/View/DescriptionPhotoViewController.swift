//
//  DescriptionPhotoViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.09.2022.
//

import UIKit

class DescriptionPhotoViewController: UIViewController {
    var presenter: DescriptionPhotoPresenter

    weak var delegate: DescriptionPhotoViewControllerDelegate?

    private let imageView = UIImageView()
    private let locationLabel = UILabel()
    private let authorNameLabel = UILabel()
    private let downloadsCountLabel = UILabel()
    private let createDateLabel = UILabel()
    private let likeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.checkLikes()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkLikeButton()
    }

    init(presenter: DescriptionPhotoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func likeButtonTapped() {
        presenter.changeButton()
        checkLikeButton()
    }

    private func checkLikeButton() {
        if likeButton.imageView?.image == UIImage(systemName: Constant.likeImage) {
            presenter.checkLikeButton(isLiked: true)
        } else if presenter.fromLikePhoto == true &&
        likeButton.imageView?.image == UIImage(systemName: Constant.unlikeImage) {
            presenter.checkLikeButton(isLiked: false)
        }
    }
}

// MARK: Setup UI

extension DescriptionPhotoViewController {
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = .systemFont(ofSize: 18)
        locationLabel.numberOfLines = 0
        locationLabel.textAlignment = .center
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.font = .systemFont(ofSize: 16)
        downloadsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsCountLabel.font = .systemFont(ofSize: 14)
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        createDateLabel.font = .systemFont(ofSize: 14)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

        view.addSubview(imageView)
        view.addSubview(locationLabel)
        view.addSubview(authorNameLabel)
        view.addSubview(downloadsCountLabel)
        view.addSubview(createDateLabel)
        view.addSubview(likeButton)

        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            likeButton.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            likeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 50),

            locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            locationLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),

            authorNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),

            downloadsCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadsCountLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 10),

            createDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createDateLabel.topAnchor.constraint(equalTo: downloadsCountLabel.bottomAnchor, constant: 10),
            createDateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: ViewInput

extension DescriptionPhotoViewController: DescriptionPhotoViewInput {
    func configure(photo: Photo) {
        locationLabel.text = photo.location
        authorNameLabel.text = "Author: \(photo.authorName)"
        downloadsCountLabel.text = "Downloads: \(photo.downloads)"
        createDateLabel.text = presenter.setupDate(photo: photo)
    }

    func setImage(image: UIImage) {
        imageView.image = image
    }

    func setLike(isLiked: Bool) {
        if isLiked {
            likeButton.setImage(UIImage(systemName: Constant.likeImage), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: Constant.unlikeImage), for: .normal)
        }
    }

    func passPhotoData(photo: Photo) {
        delegate?.passPhotoData(photo: photo)
    }

    func deletePhotoData(photo: Photo) {
        delegate?.deletePhotoData(photo: photo)
    }
}

// MARK: Delegate

protocol DescriptionPhotoViewControllerDelegate: AnyObject {
    func passPhotoData(photo: Photo)
    func deletePhotoData(photo: Photo)
}

protocol DescriptionPhotoViewControllerDelegateLikePhoto: AnyObject {
    func passPhotoData(photo: Photo)
    func deletePhotoData(photo: Photo)
}
