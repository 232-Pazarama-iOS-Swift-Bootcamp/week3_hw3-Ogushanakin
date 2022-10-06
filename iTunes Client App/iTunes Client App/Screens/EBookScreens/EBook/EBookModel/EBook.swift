//
//  EBook.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import Foundation

struct EBook: Decodable {
    let artistName: String?
    let trackName: String?
    let artworkLarge: URL?
    let releaseDate: String?
    let formattedPrice: String?
    let genres: [String]?
    let shortDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case artworkLarge = "artworkUrl100"
        case releaseDate
        case formattedPrice
        case genres
        case shortDescription
    }
}
