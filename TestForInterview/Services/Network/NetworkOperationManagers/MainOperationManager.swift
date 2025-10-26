//
//  MainOperationManager.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

struct TopRatedModelResponse: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults : Int
    
    let results: [MoviesModel]
}

struct MoviesModel: Decodable {
    let adult: Bool
    let backdropPath: String
        
    let id: Int
    let genreIds: [Int]

    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

final class MainOperationManager: NetworkOperationManager {
    
    func getOrdersList(page: Int) -> NetworkOperation<TopRatedModelResponse> {
        var param: [String: String] = [:]
        param["page"] = String(page)
        param["language"] = "en-US"

        let request = Request(url: NetworkEndpoints.Config.movieTopRated.endpoint, method: .get, query: param)
        return prepare(request: request)
    }
}
