//
//  NetworkEndpoints.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

enum NetworkEndpoints {
    enum Movies {
        case movieTopRated
        case movieDetails(Int)
        
        var endpoint: Endpoint {
            switch self {
            case .movieTopRated:
                return Endpoint("movie/top_rated")
            case .movieDetails(let id):
                return Endpoint("movie/\(id)")
            }
        }
    }
}
