//
//  APIError.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

public protocol BaseRestErrorProtocol: Decodable {}

public enum APIError<RestError>: Error where RestError: BaseRestErrorProtocol {
    case serverError(statusCode: Int, error: RestError?)
    case executionError(error: Error)
    case emptyResponse
    case decodindError
    case uknown
}
