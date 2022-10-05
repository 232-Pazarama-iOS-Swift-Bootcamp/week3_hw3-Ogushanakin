//
//  PodcastDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

final class PodcastDetailViewController: UIViewController {

    var favouritePodcasts: [Podcast?] = []
    
    var podcast: Podcast? {
        didSet {
            title = podcast?.trackName
            detailView.imageView.downloadImage(from: podcast?.artworkLarge)
            detailView.releaseDate = podcast?.releaseDate
            detailView.artistName = podcast?.artistName
            detailView.country = podcast?.country
            detailView.genres = podcast?.genres?.reduce("") { $1 + ", " + $0 }
        }
    }
    
    
    private let detailView = PodcastDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}
