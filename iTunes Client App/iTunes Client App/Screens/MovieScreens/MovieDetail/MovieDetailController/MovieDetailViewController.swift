//
//  MovieDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    var favouritesList: [Movie] = []

    var movie: Movie? {
        didSet {
            title = movie?.trackName
            movieDetailView.imageView.downloadImage(from: movie?.artworkLarge)
            movieDetailView.releaseDate = movie?.releaseDate
            movieDetailView.artistName = movie?.artistName
            movieDetailView.country = movie?.country
            movieDetailView.primaryGenreName = movie?.primaryGenreName
            movieDetailView.shortDescription = movie?.shortDescription
        }
    }
    
    private let movieDetailView = MovieDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movieDetailView
        
        configureItems()
    }

    private func configureItems() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourites", image: UIImage(systemName: "star"), target: self, action: #selector(favouriteList))
    }
    
    
    @objc private func favouriteList() {
        let detailViewController = MovieFavouritesViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}
