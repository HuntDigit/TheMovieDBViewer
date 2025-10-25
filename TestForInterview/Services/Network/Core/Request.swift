//
//  Request.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

enum APIMethod: String {
    case get    = "GET"
    case post   = "POST"
    case delete = "DELETE"
    case put    = "PUT"
    case patch  = "PATCH"
}

enum RequestState {
    case started
    case ended
}

struct Request {
    let url: Endpoint
    let method: APIMethod
    var query: [String: Any]?
    var withAuthorization: Bool = false
    var headers: [String: String]?
    var body: Encodable?
    
    init(url: Endpoint,
         method: APIMethod,
         query: [String: Any]? = nil,
         withAuthorization: Bool = false,
         headers: [String: String]? = nil,
         body: Encodable? = nil
    ) {
        self.url = url
        self.method = method
        self.query = query
        self.withAuthorization = withAuthorization
        self.headers = headers
        self.body = body
    }
    
    func finalURL(baseURL: String) -> URL {
        return url.path(baseURL: baseURL, query: query)
    }
}

extension Encodable {
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension KeyedDecodingContainer {
    public func decode<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
}
