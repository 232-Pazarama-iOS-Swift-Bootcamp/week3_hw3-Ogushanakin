//
//  MovieFavouritesViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import UIKit

final class MovieFavouritesViewController: UIViewController {

    // MARK: - Properties
    private let movieView = MovieFavouritesView()
    private let networkService = BaseNetworkService()
    private var movieResponse: MovieResponse? {
        didSet {
            movieView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = movieView
        movieView.setCollectionViewDelegate(self, andDataSource: self)
        
        fetchMovie()
    }
    
    // MARK: - Methods
    private func fetchMovie(with text: String = "Movie") {
        networkService.request(MovieRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.movieResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MovieFavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = MovieFavouriteListDetailViewController()
        detailViewController.movie = movieResponse?.results?[indexPath.row]
        detailViewController.modalTransitionStyle = .coverVertical
        present(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieFavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviecell", for: indexPath) as! MovieCollectionViewCell
        let movie = movieResponse?.results?[indexPath.row]
        cell.title = movie?.trackName
        cell.imageView.downloadImage(from: movie?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
}
