//
//  AppRequest.swift
//  iTunes Client App
//
//  Created by AKIN on 6.10.2022.
//

import Foundation

struct AppRequest: DataRequest {
    
    var searchText: String
    
    var baseURL: String {
        "https://itunes.apple.com"
    }
    
    var url: String {
        "/search"
    }
    
    var queryItems: [String : String] {
        ["term": searchText,
         "media" : "software"]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(searchText: String = "App") {
        self.searchText = searchText
    }
    
    func decode(_ data: Data) throws -> AppResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(AppResponse.self, from: data)
        return response
    }
}
