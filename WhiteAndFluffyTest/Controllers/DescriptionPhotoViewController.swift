//
//  DescriptionPhotoViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.09.2022.
//

import UIKit

class DescriptionPhotoViewController: UIViewController {
    var photo: Photo?
    var fromLikePhoto = false

    weak var delegate: DescriptionPhotoViewControllerDelegate?

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
        configure(photo: photo ?? Photo(authorName: "", createDate: "", downloads: 0, location: "", smallPhoto: "", fullPhoto: "", id: ""))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkLikeButton()
    }

    private func configure(photo: Photo) {
        locationLabel.text = photo.location
        authorNameLabel.text = "Author: \(photo.authorName)"
        downloadsCountLabel.text = "Downloads: \(photo.downloads)"
        createDateLabel.text = setupDate(photo: photo)
        DispatchQueue.global().async {
            guard let imageURL = URL(string: photo.fullPhoto) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.image.image = UIImage(data: imageData)
            }
        }
        if fromLikePhoto == true {
            likeButton.setImage(UIImage(systemName: Constant.likeImage), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: Constant.unlikeImage), for: .normal)
        }
        
    }

    private func setupDate(photo: Photo) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: photo.createDate) ?? Date()
        let convertDate = DateFormatter()
        convertDate.dateFormat = "dd MMMM yyyy hh:mm"
        convertDate.locale = Locale(identifier: "en_EN")
        let finalDate = convertDate.string(from: date)
        return finalDate
    }

    @objc private func likeButtonTapped() {
        if likeButton.imageView?.image == UIImage(systemName: Constant.likeImage) {
            likeButton.setImage(UIImage(systemName: Constant.unlikeImage), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: Constant.likeImage), for: .normal)
        }
    }

    private func checkLikeButton() {
        guard let photo = photo else { return }
        if likeButton.imageView?.image == UIImage(systemName: Constant.likeImage) {
            PhotoStorage().appendPhoto([photo])
            delegate?.passPhotoData(photo: photo)
        } else if fromLikePhoto == true && likeButton.imageView?.image == UIImage(systemName: Constant.unlikeImage) {
            delegate?.deletePhotoData(photo: photo)
        }
    }
}

//MARK: Setup UI

extension DescriptionPhotoViewController {
    private func setupUI() {
        image.translatesAutoresizingMaskIntoConstraints = false
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

        view.addSubview(image)
        view.addSubview(locationLabel)
        view.addSubview(authorNameLabel)
        view.addSubview(downloadsCountLabel)
        view.addSubview(createDateLabel)
        view.addSubview(likeButton)

        NSLayoutConstraint.activate([
            image.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            likeButton.leftAnchor.constraint(equalTo: image.leftAnchor),
            likeButton.topAnchor.constraint(equalTo: image.bottomAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 50),

            locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            locationLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),

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

//MARK: Delegate

protocol DescriptionPhotoViewControllerDelegate: AnyObject {
    func passPhotoData(photo: Photo)
    func deletePhotoData(photo: Photo)
}

protocol DescriptionPhotoViewControllerDelegateLikePhoto: AnyObject {
    func passPhotoData(photo: Photo)
    func deletePhotoData(photo: Photo)
}
