//
//  CollectionPhotosViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 03.09.2022.
//

import UIKit

class CollectionPhotosViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    private var photoData: [PhotoData] = []
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        DispatchQueue.global().async {
            NetworkManager().fetchData { photo in
                self.photoData = photo
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } onError: { error in
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionPhotoViewCell.identifier, for: indexPath) as? CollectionPhotoViewCell,
           let photo = photoData[safe: indexPath.row] {
            cell.configure(photo: photo)
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: Setup UI

extension CollectionPhotosViewController {
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(CollectionPhotoViewCell.self, forCellWithReuseIdentifier: CollectionPhotoViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView ?? UICollectionView())
    }
}
