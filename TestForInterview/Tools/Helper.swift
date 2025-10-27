//
//  Helper.swift
//  TestForInterview
//
//  Created by Sam Titovskyi on 18.08.2025.
//

import Foundation

class Helper {
    
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZDUzYjRiNWExNTE4Y2JmOTEzMmU2MTU2Mzk1YmUzYiIsIm5iZiI6MTc0NDExMTc2NS4xOTkwMDAxLCJzdWIiOiI2N2Y1MDg5NWVkZGVjMjhiMDNhZGQ1ZjUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xhPFttHQXEVDOAv7kOWJddyAJdJjBJV2UP-2xMEwLcs"
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static let baseURL = "https://api.themoviedb.org"
    static let version = "3"
}

extension MoviesModel {
    var fullPosterURL: URL? {
        URL(string: Helper.imageBaseURL + posterPath)
    }
}
