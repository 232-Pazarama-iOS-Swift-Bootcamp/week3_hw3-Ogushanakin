//
//  EBookFavouriteListDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import UIKit

class EBookFavouriteListDetailViewController: UIViewController {

    var ebook: EBook? {
        didSet {
            title = ebook?.trackName
            eBookDetailFavouriteView.imageView.downloadImage(from: ebook?.artworkLarge)
            eBookDetailFavouriteView.releaseDate = ebook?.releaseDate
            eBookDetailFavouriteView.artistName = ebook?.artistName
            eBookDetailFavouriteView.formattedPrice = ebook?.formattedPrice
            eBookDetailFavouriteView.genres = ebook?.genres?.reduce("") { $1 + ", " + $0 }
            eBookDetailFavouriteView.trackName = ebook?.trackName
        }
    }
    
    private let eBookDetailFavouriteView = EBookFavouriteListDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = eBookDetailFavouriteView
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
