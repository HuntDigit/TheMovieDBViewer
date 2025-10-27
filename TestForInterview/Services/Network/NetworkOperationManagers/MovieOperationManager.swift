//
//  MovieOperationManager.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

final class MovieOperationManager: NetworkOperationManager {
    
    func getOrdersList(page: Int) -> NetworkOperation<TopRatedModelResponse> {
        var param: [String: String] = [:]
        param["page"] = String(page)
        param["language"] = "en-US"

        let request = Request(url: NetworkEndpoints.Movies.movieTopRated.endpoint, method: .get, query: param)
        return prepare(request: request)
    }
    
    func getMovieDetails(id: Int) -> NetworkOperation<TopRatedModelResponse> {
        
        let request = Request(url: NetworkEndpoints.Movies.movieTopRated.endpoint, method: .get)
        return prepare(request: request)
    }
}
