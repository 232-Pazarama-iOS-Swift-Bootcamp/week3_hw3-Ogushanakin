//
//  PodcastResponse.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import Foundation

struct PodcastResponse: Decodable {
    let resultCount: Int?
    let results: [Podcast]?
}
