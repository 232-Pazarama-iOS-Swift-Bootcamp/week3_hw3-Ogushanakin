//
//  AppFavouritesViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 7.10.2022.
//

import UIKit

final class AppFavouritesViewController: UIViewController {

    // MARK: - Properties
    private let appView = AppView()
    private let networkService = BaseNetworkService()
    private var appResponse: AppResponse? {
        didSet {
            appView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = appView
        appView.setCollectionViewDelegate(self, andDataSource: self)
        
        fetchApp()
    }
    
    // MARK: - Methods
    private func fetchApp(with text: String = "App") {
        networkService.request(AppRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.appResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AppFavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = AppFavouriteListDetailViewController()
        detailViewController.app = appResponse?.results?[indexPath.row]
        detailViewController.modalTransitionStyle = .coverVertical
        present(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension AppFavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appcell", for: indexPath) as! AppCollectionViewCell
        let app = appResponse?.results?[indexPath.row]
        cell.title = app?.trackName
        cell.imageView.downloadImage(from: app?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
