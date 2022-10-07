//
//  MusicFavouritesViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 7.10.2022.
//

import UIKit

final class MusicFavouritesViewController: UIViewController {

    // MARK: - Properties
    private let musicView = MusicView()
    private let networkService = BaseNetworkService()
    private var musicResponse: MusicResponse? {
        didSet {
            musicView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = musicView
        musicView.setCollectionViewDelegate(self, andDataSource: self)
        
        fetchMusic()
    }
    
    // MARK: - Methods
    private func fetchMusic(with text: String = "Music") {
        networkService.request(MusicRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.musicResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MusicFavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = MusicFavouriteListDetailViewController()
        detailViewController.music = musicResponse?.results?[indexPath.row]
        detailViewController.modalTransitionStyle = .coverVertical
        present(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MusicFavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musiccell", for: indexPath) as! MusicCollectionViewCell
        let music = musicResponse?.results?[indexPath.row]
        cell.title = music?.trackName
        cell.imageView.downloadImage(from: music?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
