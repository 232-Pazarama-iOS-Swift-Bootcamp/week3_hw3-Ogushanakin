//
//  EBookViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

final class EBookViewController: UIViewController {

    // MARK: - Properties
    private let eBookView = EBookView()
    private let networkService = BaseNetworkService()
    private let searchController = UISearchController()
    private var eBookResponse: EBookResponse? {
        didSet {
            eBookView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "E-Books"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = eBookView
        eBookView.setCollectionViewDelegate(self, andDataSource: self)
        
        searchBarController()
        fetchEBook()
    }
    
    // MARK: - Methods
    private func fetchEBook(with text: String = "EBook") {
        networkService.request(EBookRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.eBookResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func searchBarController() {
        searchController.searchBar.placeholder = "Trending Movies..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

// MARK: - UICollectionViewDelegate
extension EBookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = EBookDetailViewController()
        detailViewController.ebook = eBookResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension EBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        eBookResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ebookcell", for: indexPath) as! EBookCollectionViewCell
        let ebook = eBookResponse?.results?[indexPath.row]
        cell.title = ebook?.trackName
        cell.imageView.downloadImage(from: ebook?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
// MARK: - UISearchResultsUpdating
extension EBookViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchEBook(with: text)
        }
    }
}
