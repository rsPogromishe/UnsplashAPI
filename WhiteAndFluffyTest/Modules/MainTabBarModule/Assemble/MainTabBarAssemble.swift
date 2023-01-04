//
//  MainTabBarAssemble.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.01.2023.
//

import UIKit

class MainTabBarAssemble {
    static func assembleMainTabBarModule() -> UITabBarController {
        let controller = MainTabBarController()

        guard let collectionImage = UIImage(systemName: Constant.collectionImage) else { return UITabBarController() }
        let collectionVC = MainTabBarAssemble.generateViewController(
            rootViewController: CollectionPhotosAssemble.assembleCollectionPhotosModule(),
            image: collectionImage,
            title: "Collection"
        )

        guard let likeImage = UIImage(systemName: Constant.unlikeImage) else { return UITabBarController() }
        let likePhotoVC = MainTabBarAssemble.generateViewController(
            rootViewController: LikePhotosAssemble.assembleLikePhotosModule(),
            image: likeImage,
            title: "Likes"
        )

        controller.setViewControllers([collectionVC, likePhotoVC], animated: true)
        return controller
    }

    static func generateViewController(
        rootViewController: UIViewController,
        image: UIImage,
        title: String
    ) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.backgroundColor = .white
        navigationVC.navigationBar.tintColor = .black
        return navigationVC
    }
}
