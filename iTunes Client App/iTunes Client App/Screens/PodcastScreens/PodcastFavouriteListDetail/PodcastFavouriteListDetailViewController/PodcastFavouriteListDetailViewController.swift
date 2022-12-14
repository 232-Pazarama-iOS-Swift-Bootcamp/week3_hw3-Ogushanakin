//
//  PodcastFavouriteListDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import UIKit

final class PodcastFavouriteListDetailViewController: UIViewController {

    // MARK: - Properties
    var podcast: Podcast? {
        didSet {
            title = podcast?.trackName
            podcastDetailFavouriteView.imageView.downloadImage(from: podcast?.artworkLarge)
            podcastDetailFavouriteView.releaseDate = podcast?.releaseDate
            podcastDetailFavouriteView.artistName = podcast?.artistName
            podcastDetailFavouriteView.country = podcast?.country
            podcastDetailFavouriteView.genres = podcast?.genres?.reduce("") { $1 + ", " + $0 }
            podcastDetailFavouriteView.trackName = podcast?.trackName
        }
    }
    
    private let podcastDetailFavouriteView = PodcastFavouriteListDetailView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = podcastDetailFavouriteView
        navigationController?.navigationBar.prefersLargeTitles = false
    }  

}
