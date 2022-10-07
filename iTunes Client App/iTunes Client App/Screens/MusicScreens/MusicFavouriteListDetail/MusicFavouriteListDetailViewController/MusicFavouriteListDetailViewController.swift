//
//  MusicFavouriteListDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 7.10.2022.
//

import UIKit

final class MusicFavouriteListDetailViewController: UIViewController {

    var music: Music? {
        didSet {
            title = music?.trackName
            musicDetailFavouriteView.imageView.downloadImage(from: music?.artworkLarge)
            musicDetailFavouriteView.releaseDate = music?.releaseDate
            musicDetailFavouriteView.artistName = music?.artistName
            musicDetailFavouriteView.country = music?.country
            musicDetailFavouriteView.primaryGenreName = music?.primaryGenreName
            musicDetailFavouriteView.collectionName = music?.collectionName
        }
    }
    
    private let musicDetailFavouriteView = MusicFavouriteListDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = musicDetailFavouriteView
        
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
