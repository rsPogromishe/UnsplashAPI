//
//  CollectionPhotosViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 03.09.2022.
//

import UIKit

class CollectionPhotosViewController: UIViewController {
    private var photoData: [Photo] = []

    private var collectionView: UICollectionView?
    private let searchBar = UISearchController()
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearch()
        DispatchQueue.global().async {
            NetworkManager().fetchData(requestType: .random) { photo in
                self.photoData = photo
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } onError: { error in
                print(error)
            }
        }
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

    private func setupSearch() {
        navigationItem.searchController = searchBar
        searchBar.searchResultsUpdater = self
        searchBar.delegate = self
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Search..."
    }
}

//MARK: Setup CollectionView

extension CollectionPhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DescriptionPhotoViewController()
        vc.delegate = self
        vc.photo = photoData[indexPath.row]
        vc.fromLikePhoto = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Setup SearchBar

extension CollectionPhotosViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.isEmpty == false {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                let searchText = searchController.searchBar.text
                DispatchQueue.global().async {
                    NetworkManager().fetchData(requestType: .search(searchTerms: searchText ?? "")) { photo in
                        self.photoData = photo
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    } onError: { error in
                        print(error)
                    }
                }
            })
        }
    }
}

extension CollectionPhotosViewController: DescriptionPhotoViewControllerDelegate {
    func passPhotoData(photo: Photo) {
    }

    func deletePhotoData(photo: Photo) {
    }
}
