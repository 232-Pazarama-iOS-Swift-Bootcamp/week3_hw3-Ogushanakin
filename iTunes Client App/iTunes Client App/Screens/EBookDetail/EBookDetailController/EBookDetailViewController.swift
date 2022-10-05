//
//  EBookDetailViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

final class EBookDetailViewController: UIViewController {

    var ebook: EBook? {
        didSet {
            title = ebook?.trackName
            eBookDetailView.imageView.downloadImage(from: ebook?.artworkLarge)
            eBookDetailView.releaseDate = ebook?.releaseDate
            eBookDetailView.artistName = ebook?.artistName
            eBookDetailView.country = ebook?.country
            eBookDetailView.primaryGenreName = ebook?.primaryGenreName
            eBookDetailView.shortDescription = ebook?.shortDescription
        }
    }
    
    private let eBookDetailView = EBookDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "E-Books"
        view = eBookDetailView
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}
