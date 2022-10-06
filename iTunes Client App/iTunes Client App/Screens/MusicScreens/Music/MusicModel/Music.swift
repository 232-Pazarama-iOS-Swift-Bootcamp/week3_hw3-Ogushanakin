//
//  Music.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import Foundation

struct Music: Decodable {
    let artistName: String?
    let trackName: String?
    let artworkLarge: URL?
    let releaseDate: String?
    let country: String?
    let primaryGenreName: String?
    let collectionName: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case artworkLarge = "artworkUrl100"
        case releaseDate
        case country
        case primaryGenreName
        case collectionName
    }
}
