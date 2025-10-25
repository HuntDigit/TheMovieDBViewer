//
//  BaseRestResponse.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

class BaseRestResponse<Model>: Decodable where Model: Decodable {
    let result: [Model]

    init(result: [Model]) {
        self.result = result
    }
}
