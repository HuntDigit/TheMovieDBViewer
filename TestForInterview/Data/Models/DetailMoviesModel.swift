//
//  DetailMoviesModel.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import Foundation

struct DetailMoviesModel: Decodable {
    let adult: Bool
    let backdropPath: String
        
    let id: Int
//    let genreIds: [Int]

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
