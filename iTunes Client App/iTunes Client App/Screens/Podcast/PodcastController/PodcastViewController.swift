//
//  PodcastViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

class PodcastViewController: UIViewController {

    // MARK: - Properties
    private let podcastView = PodcastView()
    private let networkService = BaseNetworkService()
    private let searchController = UISearchController()
    private var podcastResponse: PodcastResponse? {
        didSet {
            podcastView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Podcasts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = podcastView
        podcastView.setCollectionViewDelegate(self, andDataSource: self)
        
        
        searchBarController()
        fetchPodcasts()
    }
    
    // MARK: - Methods
    private func fetchPodcasts(with text: String = "Podcast") {
        networkService.request(PodcastRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.podcastResponse = response
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
extension PodcastViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = PodcastDetailViewController()
        detailViewController.podcast = podcastResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcastResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PodcastCollectionViewCell
        let podcast = podcastResponse?.results?[indexPath.row]
        cell.title = podcast?.trackName
        cell.imageView.downloadImage(from: podcast?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
// MARK: - UISearchResultsUpdating
extension PodcastViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchPodcasts(with: text)
        }
    }
}
    

