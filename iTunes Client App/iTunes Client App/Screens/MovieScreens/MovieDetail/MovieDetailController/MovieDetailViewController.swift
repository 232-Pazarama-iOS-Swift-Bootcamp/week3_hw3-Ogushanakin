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
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star") , style: .plain, target: self, action: #selector(addTapped))
    }

    @objc func addTapped() {
        favouritesList.append(movie!)
        print("\(String(describing: movie?.trackName))")
    }

}
