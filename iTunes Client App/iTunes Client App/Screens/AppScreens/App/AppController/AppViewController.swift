//
//  AppViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 5.10.2022.
//

import UIKit

final class AppViewController: UIViewController {

    // MARK: - Properties
    private let appView = AppView()
    private let networkService = BaseNetworkService()
    private let searchController = UISearchController()
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
        
        searchBarController()
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
    
    private func searchBarController() {
        searchController.searchBar.placeholder = "Search App..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

// MARK: - UICollectionViewDelegate
extension AppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = AppDetailViewController()
        detailViewController.app = appResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension AppViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appResponse?.results?.count ?? .zero
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
// MARK: - UISearchResultsUpdating
extension AppViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchApp(with: text)
        }
    }
}
