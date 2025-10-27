//
//  MoviesModel.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import Foundation

struct MoviesModel: Decodable, Hashable {
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

extension MoviesModel {
    static let empty: MoviesModel = .init(
        adult: false,
        backdropPath: "",
        id: 0,
        genreIds: [],
        originalLanguage: "",
        originalTitle: "",
        overview: "",
        popularity: 0.0,
        posterPath: "",
        releaseDate: "",
        title: "",
        video: false,
        voteAverage: 0.0,
        voteCount: 0
    )
}
