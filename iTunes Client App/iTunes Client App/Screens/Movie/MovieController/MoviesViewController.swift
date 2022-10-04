//
//  MoviesViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - Properties
    private let movieView = MovieView()
    private let networkService = BaseNetworkService()
    private let searchController = UISearchController()
    private var movieResponse: MovieResponse? {
        didSet {
            movieView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = movieView
        movieView.setCollectionViewDelegate(self, andDataSource: self)
        
        
        searchBarController()
        fetchMovies()
    }
    
    // MARK: - Methods
    private func fetchMovies(with text: String = "Movie") {
        networkService.request(MovieRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.movieResponse = response
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
extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = MovieDetailViewController()
        detailViewController.movie = movieResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieResponse?.results?.count ?? .zero
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
// MARK: - UISearchResultsUpdating
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchMovies(with: text)
        }
    }
}
