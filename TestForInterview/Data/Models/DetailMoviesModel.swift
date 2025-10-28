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

    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
}

extension DetailMoviesModel {
    var releaseDateFormated: String {
        DateFormatterHelper().formatDate(self.releaseDate) ?? "N/A"
    }
}
