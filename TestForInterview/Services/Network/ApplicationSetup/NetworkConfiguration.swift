//
//  NetworkConfiguration.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

struct NetworkConfiguration {
    var version: String?
    var baseApiURL: String
    var baseHeaders: [String: String] = [:]
    
    init(baseURL: String, version: String? = nil) {
        self.baseApiURL = baseURL
        self.version = version
        self.baseHeaders = [
            "Content-type"  : "application/json",
            "Accept"        : "application/json"
        ]
    }
    
    mutating func setHeader(key: String, value: String) {
        baseHeaders[key] = value
    }
    
    mutating func setAutorization(key: String = "Authorization", token: String) {
        baseHeaders[key] = "Bearer \(token)"
    }
}

extension NetworkConfiguration: СonfigurationProvider {
    var headers: [String : String] {
        self.baseHeaders
    }
    
    var baseURL: String {
        guard let version else { return self.baseApiURL }
        return [self.baseApiURL, version].joined(separator: "/")
    }
    
    var decodePolicy: DecodePolicy { .convertFromSnakeCase }
}
