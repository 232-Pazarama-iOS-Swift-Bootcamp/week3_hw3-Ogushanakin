//
//  EBookResponse.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import Foundation

struct EBookResponse: Decodable {
    let resultCount: Int?
    let results: [EBook]?
}
