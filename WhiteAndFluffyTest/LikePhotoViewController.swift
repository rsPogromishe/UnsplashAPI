//
//  FavoritePhotoViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import UIKit

class LikePhotoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LikePhotoTableViewCell.identifier) as? LikePhotoTableViewCell {
            cell.configure()
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: Setup UI

extension LikePhotoViewController {
    private func setupUI() {
        tableView = UITableView(frame: self.view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(LikePhotoTableViewCell.self, forCellReuseIdentifier: LikePhotoTableViewCell.identifier)
        self.view.addSubview(tableView ?? UITableView())
    }
}
