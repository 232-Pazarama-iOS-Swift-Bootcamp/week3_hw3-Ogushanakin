//
//  MovieResponse.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import Foundation

struct MovieResponse: Decodable {
    let resultCount: Int?
    let results: [Movie]?
}
