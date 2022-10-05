//
//  MusicDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

final class MusicDetailViewController: UIViewController {

    var music: Music? {
        didSet {
            title = music?.trackName
            musicDetailView.imageView.downloadImage(from: music?.artworkLarge)
            musicDetailView.releaseDate = music?.releaseDate
            musicDetailView.artistName = music?.artistName
            musicDetailView.country = music?.country
            musicDetailView.primaryGenreName = music?.primaryGenreName
            musicDetailView.shortDescription = music?.shortDescription
        }
    }
    
    private let musicDetailView = MusicDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = musicDetailView
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}
