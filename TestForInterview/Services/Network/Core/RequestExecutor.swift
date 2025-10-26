//
//  RequestExecutor.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

protocol СonfigurationProvider {
    typealias DecodePolicy = JSONDecoder.KeyDecodingStrategy
    
    var headers: [String: String] { get }
    var baseURL: String { get }
    
    var decodePolicy: DecodePolicy { get }
}

final class RequestExecutor: NSObject {
    var currentConfiguration: СonfigurationProvider
    
    init(configuration: СonfigurationProvider) {
        self.currentConfiguration = configuration
    }

    func execute<Model, RestError>(request: Request, completion: @escaping RequestCompletion<Model, RestError>) -> URLSessionTask {
        return performTask(request: request, completion: completion)
     }

    private func performTask<Model, RestError>(request: Request, completion: @escaping RequestCompletion<Model, RestError>) -> URLSessionTask {

        let url = currentConfiguration.baseURL
        let headers = currentConfiguration.headers

        var urlRequest = URLRequest(url: request.finalURL(baseURL: url))
        urlRequest.httpMethod = request.method.rawValue
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        urlRequest.httpBody = request.body?.json

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                self.processResponse(data: data, response: response, error: error, completion: completion)
            }
        }
        
        return task
    }

    private func processResponse<Model, RestError>(data: Data?,
                                                   response: URLResponse?,
                                                   error: Error?,
                                                   completion: RequestCompletion<Model, RestError>)
    where Model: Decodable {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = currentConfiguration.decodePolicy
        
        if let error = error {
            completion(.failure(.executionError(error: error)))
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            var errorInfo: RestError?
            if let data = data,
               let info = try? decoder.decode(RestError.self, from: data) {
                errorInfo = info
            }
            
            if httpResponse.statusCode != 200 {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode, error: errorInfo)))
                return
            }
        }
        
        guard let data = data else {
            completion(.failure(.emptyResponse))
            return
        }
        
        do {
            let model = try decoder.decode(Model.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(.decodindError))
        }
    }
}
