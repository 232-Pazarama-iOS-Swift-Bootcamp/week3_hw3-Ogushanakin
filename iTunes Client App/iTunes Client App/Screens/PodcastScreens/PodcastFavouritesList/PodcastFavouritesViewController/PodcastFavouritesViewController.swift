//
//  ViewControllerPodcastFavouritesViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import UIKit

final class PodcastFavouritesViewController: UIViewController {

    // MARK: - Properties
    private let podcastView = PodcastFavouritesView()
    private let networkService = BaseNetworkService()
    private var podcastResponse: PodcastResponse? {
        didSet {
            podcastView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = podcastView
        podcastView.setCollectionViewDelegate(self, andDataSource: self)
        
        fetchPodcast()
    }
    
    // MARK: - Methods
    private func fetchPodcast(with text: String = "Podcast") {
        networkService.request(PodcastRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.podcastResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PodcastFavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = PodcastFavouriteListDetailViewController()
        detailViewController.podcast = podcastResponse?.results?[indexPath.row]
        detailViewController.modalTransitionStyle = .coverVertical
        present(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension PodcastFavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastcell", for: indexPath) as! PodcastCollectionViewCell
        let podcast = podcastResponse?.results?[indexPath.row]
        cell.title = podcast?.trackName
        cell.imageView.downloadImage(from: podcast?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }

}
