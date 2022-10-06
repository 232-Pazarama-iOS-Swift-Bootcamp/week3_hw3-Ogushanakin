//
//  EBookDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit
import CoreData

final class EBookDetailViewController: UIViewController {
    
    var ebook: EBook? {
        didSet {
            title = ebook?.trackName
            eBookDetailView.imageView.downloadImage(from: ebook?.artworkLarge)
            eBookDetailView.releaseDate = ebook?.releaseDate
            eBookDetailView.artistName = ebook?.artistName
            eBookDetailView.formattedPrice = ebook?.formattedPrice
            eBookDetailView.genres = ebook?.genres?.reduce("") { $1 + ", " + $0 }
            eBookDetailView.trackName = ebook?.trackName
        }
    }
    
    private let eBookDetailView = EBookDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = eBookDetailView
        
        configureItems()
    }

    private func configureItems() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourites", image: UIImage(systemName: "star"), target: self, action: #selector(favouriteList))
    }
    
    @objc private func favouriteList() {
        let detailViewController = EBookFavouritesViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
