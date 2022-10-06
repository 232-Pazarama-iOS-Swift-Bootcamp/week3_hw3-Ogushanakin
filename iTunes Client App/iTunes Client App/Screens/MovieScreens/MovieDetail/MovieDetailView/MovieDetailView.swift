//
//  MovieDetailView.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

class MovieDetailView: UIView {

    var releaseDate: String? {
        didSet {
            releaseDateKeyLabel.text = "Release Date:"
            releaseDateKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            releaseDateLabel.text = releaseDate ?? "-"
        }
    }
    
    var artistName: String? {
        didSet {
            artistNameKeyLabel.text = "Artist Name:"
            artistNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            artistNameLabel.text = artistName ?? "-"
        }
    }
    
    var country: String? {
        didSet {
            countryKeyLabel.text = "Country:"
            countryKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            countryLabel.text = country ?? "-"
        }
    }
    
    var primaryGenreName: String? {
        didSet {
            genresKeyLabel.text = "Genres:"
            genresKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            genresLabel.text = primaryGenreName ?? "-"
        }
    }
    
    var shortDescription: String? {
        didSet {
            longDescriptionKeyLabel.text = "Description:"
            longDescriptionKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            longDescriptionLabel.text = shortDescription ?? "-"
        }
    }
    
    
    
    private(set) var imageView = UIImageView()
    
    private let releaseDateKeyLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private lazy var releaseDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateKeyLabel, UIView(), releaseDateLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var artistNameKeyLabel = UILabel()
    private var artistNameLabel = UILabel()
    private lazy var artistNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistNameKeyLabel, UIView(), artistNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var countryKeyLabel = UILabel()
    private var countryLabel = UILabel()
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryKeyLabel, UIView(), countryLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var genresKeyLabel = UILabel()
    private var genresLabel = UILabel()
    private lazy var genresStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genresKeyLabel, UIView(), genresLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var longDescriptionKeyLabel = UILabel()
    private var longDescriptionLabel = UILabel()
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [longDescriptionKeyLabel, UIView(), longDescriptionLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        releaseDateLabel.numberOfLines = .zero
        artistNameLabel.numberOfLines = .zero
        countryLabel.numberOfLines = .zero
        genresLabel.numberOfLines = .zero
        longDescriptionLabel.numberOfLines = .zero
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .screenWidth)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [releaseDateStackView,
                                                       artistNameStackView,
                                                       countryStackView,
                                                       genresStackView,
                                                       descriptionStackView])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
