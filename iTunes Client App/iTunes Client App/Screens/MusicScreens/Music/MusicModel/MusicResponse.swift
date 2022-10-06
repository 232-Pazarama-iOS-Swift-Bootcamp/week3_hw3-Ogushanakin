//
//  MusicResponse.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import Foundation

struct MusicResponse: Decodable {
    let resultCount: Int?
    let results: [Music]?
}
