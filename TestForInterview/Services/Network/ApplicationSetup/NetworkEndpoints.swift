//
//  NetworkEndpoints.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

enum NetworkEndpoints {
    enum Config {
        case movieTopRated
 
        var endpoint: Endpoint {
            switch self {
            case .movieTopRated:
                return Endpoint("movie/top_rated")
            }
        }
    }
}
