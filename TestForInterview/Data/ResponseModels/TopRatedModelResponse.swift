//
//  ResponseModels.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import Foundation

struct TopRatedModelResponse: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults : Int
    
    let results: [MoviesModel]
}

