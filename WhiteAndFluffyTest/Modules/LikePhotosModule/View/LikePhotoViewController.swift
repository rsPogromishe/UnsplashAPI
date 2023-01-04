//
//  FavoritePhotoViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import UIKit

class LikePhotoViewController: UIViewController {
    var presenter: LikePhotosPresenter

    private var tableView: UITableView?
    private let textIfEmpty = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewWillAppear()
        tableView?.reloadData()
    }

    init(presenter: LikePhotosPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup UI

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
            textIfEmpty.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: Setup TableView

extension LikePhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.photoData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: LikePhotoTableViewCell.identifier
        ) as? LikePhotoTableViewCell,
           let photo = presenter.photoData[safe: indexPath.row] {
            cell.configure(photo: photo)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = presenter.photoData[safe: indexPath.row] else { return }
        let vc = DescriptionPhotoAssemble.assembleDescriptionPhoto(
            photo: photo,
            fromLikePhoto: true,
            delegate: self
        )
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Delegate

extension LikePhotoViewController: DescriptionPhotoViewControllerDelegate {
    func passPhotoData(photo: Photo) {
        presenter.passPhotoData(photo: photo)
    }

    func deletePhotoData(photo: Photo) {
        presenter.deletePhotoData(photo: photo)
    }
}

// MARK: ViewInput

extension LikePhotoViewController: LikePhotosViewInput {
    func reloadData() {
        self.tableView?.reloadData()
    }

    func showAlert(bool: Bool) {
        if bool {
            let action = UIAlertController(
                title: "No photo",
                message: "Please, add photo to favourites",
                preferredStyle: .alert
            )
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
