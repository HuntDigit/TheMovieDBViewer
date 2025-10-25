//
//  MainOperationManager.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

struct ModelResult: Decodable {
    let page: Int
    let results: [FilmModel]
}

struct FilmModel: Decodable {
    let adult: Bool
    let backdrop_path: String
}

final class MainOperationManager: NetworkOperationManager {
    
    func getOrdersList(page: Int) -> NetworkOperation<FilmModel> {
        var param: [String: String] = [:]
        param["page"] = String(page)
        param["language"] = "en-US"
        
        
        let request = Request(url: NetworkEndpoints.Config.movieTopRated.endpoint, method: .get, query: param)
        return prepare(request: request)
    }
}
