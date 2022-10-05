//
//  MovieDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

final class MovieDetailViewController: UIViewController {

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
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}
