//
//  NetworkResponse.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

final class NetworkResponse<Model: Decodable>: BaseRestResponse<Model> {
    typealias Model = Model

    let page: Int
    let results: [Model]

    enum CodingKeys: String, CodingKey {
        case page
        case results
    }

    init(result: [Model], page: Int = 0) {
        self.page = page
        self.results = result
        super.init(result: result)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(.page)
        results = try container.decode(.results)
        super.init(result: results)
    }
}
