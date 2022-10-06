//
//  LibraryViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

final class EBookFavouritesViewController: UIViewController {
    
    // MARK: - Properties
    private let eBookView = EBookView()
    private let networkService = BaseNetworkService()
    private var eBookResponse: EBookResponse? {
        didSet {
            eBookView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = eBookView
        eBookView.setCollectionViewDelegate(self, andDataSource: self)
        
        fetchEBook()
    }
    
    // MARK: - Methods
    private func fetchEBook(with text: String = "EBook") {
        networkService.request(EBookRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.eBookResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension EBookFavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = EBookFavouriteListDetailViewController()
        detailViewController.ebook = eBookResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension EBookFavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ebookcell", for: indexPath) as! EBookCollectionViewCell
        let ebook = eBookResponse?.results?[indexPath.row]
        cell.title = ebook?.trackName
        cell.imageView.downloadImage(from: ebook?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
