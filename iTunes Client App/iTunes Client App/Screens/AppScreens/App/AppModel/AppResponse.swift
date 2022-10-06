//
//  AppResponse.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import Foundation

struct AppResponse: Decodable {
    let resultCount: Int?
    let results: [App]?
}
