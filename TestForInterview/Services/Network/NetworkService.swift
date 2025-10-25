//
//  NetworkService.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

typealias NetworkOperation<Model> = RestOperation<Model, NetworkResponse<Model>, NetworkError> where Model: Decodable
typealias NetworkOperationManager = RestOperationManager<NetworkError>

class NetworkService {

    static let shared = NetworkService()
    
    private init() { setupBaseURL() }
    
    func setupBaseURL() {
        RestManager.shared.configuration = {
            var config = NetworkConfiguration(baseURL: Helper.baseURL, version: Helper.version)
            config.setAutorization(token: Helper.apiKey )
            return config
        }
    }
    
    func instantiate<T: RestOperationManager<NetworkError>>(_ type: T.Type, in context: AnyObject) -> T {
        return RestManager.shared.operationsManager(from: type, in: context)
    }
}
