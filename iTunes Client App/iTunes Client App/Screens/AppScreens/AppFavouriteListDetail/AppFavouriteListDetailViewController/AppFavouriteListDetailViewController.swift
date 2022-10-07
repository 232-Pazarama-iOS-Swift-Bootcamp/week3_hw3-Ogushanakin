//
//  AppFavouriteListDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 7.10.2022.
//

import UIKit

class AppFavouriteListDetailViewController: UIViewController {

    var app: App? {
        didSet {
            title = app?.trackName
            appDetailFavouriteView.imageView.downloadImage(from: app?.artworkLarge)
            appDetailFavouriteView.releaseDate = app?.releaseDate
            appDetailFavouriteView.artistName = app?.artistName
            appDetailFavouriteView.formattedPrice = app?.formattedPrice
            appDetailFavouriteView.genres = app?.genres?.reduce("") { $1 + ", " + $0 }
            appDetailFavouriteView.trackName = app?.trackName
        }
    }
    
    private let appDetailFavouriteView = AppFavouriteListDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = appDetailFavouriteView
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}
