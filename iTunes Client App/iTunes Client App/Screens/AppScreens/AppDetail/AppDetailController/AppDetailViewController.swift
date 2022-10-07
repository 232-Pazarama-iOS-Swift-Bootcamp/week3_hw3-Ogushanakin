//
//  AppDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import UIKit

final class AppDetailViewController: UIViewController {

    var app: App? {
        didSet {
            title = app?.trackName
            appDetailView.imageView.downloadImage(from: app?.artworkLarge)
            appDetailView.releaseDate = app?.releaseDate
            appDetailView.artistName = app?.artistName
            appDetailView.formattedPrice = app?.formattedPrice
            appDetailView.genres = app?.genres?.reduce("") { $1 + ", " + $0 }
            appDetailView.trackName = app?.trackName
        }
    }
    
    private let appDetailView = AppDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = appDetailView
        
        configureItems()
    }
    
    private func configureItems() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star") , style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let detailViewController = AppFavouritesViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}
