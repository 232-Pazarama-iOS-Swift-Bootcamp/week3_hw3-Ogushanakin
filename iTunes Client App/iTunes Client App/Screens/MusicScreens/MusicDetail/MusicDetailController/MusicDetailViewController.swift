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
            musicDetailView.collectionName = music?.collectionName
        }
    }
    
    private let musicDetailView = MusicDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = musicDetailView
        
        configureItems()
    }

    private func configureItems() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourites", image: UIImage(systemName: "star"), target: self, action: #selector(favouriteList))
    }
    
    
    @objc private func favouriteList() {
        let detailViewController = MusicFavouritesViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}
