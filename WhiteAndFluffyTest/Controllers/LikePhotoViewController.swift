//
//  FavoritePhotoViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import UIKit

class LikePhotoViewController: UIViewController {
    private var photoData: [Photo] = []
    
    private var tableView: UITableView?
    private let textIfEmpty = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        photoData = PhotoStorage().loadNotes()
        checkLikePhotos()
        tableView?.reloadData()
    }

    private func checkLikePhotos() {
        if photoData.isEmpty {
            let action = UIAlertController(title: "No photo", message: "Please, add photo to favourites", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            action.addAction(okAction)
            present(action, animated: true)

            tableView?.isHidden = true
            textIfEmpty.isHidden = false
        } else {
            tableView?.isHidden = false
            textIfEmpty.isHidden = true
        }
    }
}

//MARK: Setup UI

extension LikePhotoViewController {
    private func setupUI() {
        tableView = UITableView(frame: self.view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.register(LikePhotoTableViewCell.self, forCellReuseIdentifier: LikePhotoTableViewCell.identifier)
        self.view.addSubview(tableView ?? UITableView())

        textIfEmpty.translatesAutoresizingMaskIntoConstraints = false
        textIfEmpty.font = .systemFont(ofSize: 32)
        textIfEmpty.text = "Add photo to favourites"
        textIfEmpty.isHidden = true
        self.view.addSubview(textIfEmpty)

        NSLayoutConstraint.activate([
            textIfEmpty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textIfEmpty.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

//MARK: Setup TableView

extension LikePhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LikePhotoTableViewCell.identifier) as? LikePhotoTableViewCell,
           let entry = photoData[safe: indexPath.row] {
            cell.configure(photo: entry)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DescriptionPhotoViewController()
        vc.delegate = self
        vc.photo = photoData[indexPath.row]
        vc.fromLikePhoto = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LikePhotoViewController: DescriptionPhotoViewControllerDelegate {
    func passPhotoData(photo: Photo) {
        self.photoData.forEach { photos in
            if photos.id != photo.id {
                photoData.append(photo)
                PhotoStorage().saveNotes(photoData)
            }
        }
        tableView?.reloadData()
    }

    func deletePhotoData(photo: Photo) {
        self.photoData.removeAll(where: { $0.id == photo.id })
        PhotoStorage().saveNotes(photoData)
        tableView?.reloadData()
    }
}
