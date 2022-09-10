//
//  CollectionPhotoViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 02.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collectionImage = UIImage(systemName: Constant.collectionImage) else { return }
        guard let likeImage = UIImage(systemName: Constant.unlikeImage) else { return }

        viewControllers = [
            generateViewController(rootViewController: CollectionPhotosViewController(), image: collectionImage, title: "Collection"),
            generateViewController(rootViewController: LikePhotoViewController(), image: likeImage, title: "Likes")
        ]

        tabBar.tintColor = .black
        tabBar.backgroundColor = .secondarySystemBackground
        view.backgroundColor = .white
    }

    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.backgroundColor = .white
        navigationVC.navigationBar.tintColor = .black
        return navigationVC
    }
}
