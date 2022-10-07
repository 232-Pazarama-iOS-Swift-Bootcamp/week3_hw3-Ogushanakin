//
//  PodcastFavouriteListDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import UIKit

final class MovieFavouriteListDetailViewController: UIViewController {

    var movie: Movie? {
        didSet {
            title = movie?.trackName
            movieDetailFavouriteView.imageView.downloadImage(from: movie?.artworkLarge)
            movieDetailFavouriteView.releaseDate = movie?.releaseDate
            movieDetailFavouriteView.artistName = movie?.artistName
            movieDetailFavouriteView.country = movie?.country
            movieDetailFavouriteView.primaryGenreName = movie?.primaryGenreName
            movieDetailFavouriteView.shortDescription = movie?.shortDescription
        }
    }
    
    private let movieDetailFavouriteView = MovieFavouriteListDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movieDetailFavouriteView
        
        configureItems()
    }
    
    private func configureItems() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star") , style: .plain, target: self, action: #selector(addTapped))
    }

    @objc func addTapped() {
        print("111")
    }

}
