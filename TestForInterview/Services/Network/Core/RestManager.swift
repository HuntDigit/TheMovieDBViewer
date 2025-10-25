//
//  RestManager.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

struct EmptyConfiguration: СonfigurationProvider {
    var headers: [String : String] = [:]
    var baseURL: String = ""
}

final class RestManager: RestOperationsDelegate {
    
    static let shared = RestManager()
    private init() {}
    
    private var tasks: [String: [URLSessionTask]] = [:]
    
    private lazy var executor = RequestExecutor(configuration: configuration())
    lazy var configuration: () -> any СonfigurationProvider = {
        EmptyConfiguration()
    }
    
    func operationsManager<T, RestError>(from operationsClass: T.Type, in context: AnyObject) -> T where T: RestOperationManager<RestError> {
        let operations: T = operationsClass.init(contextIdentifier: String(describing: context))
        operations.delegate = self
        return operations
    }
    
    func execute<Model, Response, RestError>(model: Response.Type,
                                             errorType: RestError.Type,
                                             request: Request,
                                             identifier: String,
                                             completion: @escaping RequestCompletion<Model, Response, RestError>) {

        let task = executor.execute(request: request, completion: completion)

        if var existingTasks = tasks[identifier] {
            existingTasks.append(task)
            tasks[identifier] = existingTasks
        } else {
            tasks[identifier] = [task]
        }

        task.resume()
    }
 
    func cancelAllRequests(identifier: String) {
        tasks[identifier]?.forEach { $0.cancel() }
        tasks.removeValue(forKey: identifier)
    }

    deinit {
        tasks.forEach { cancelAllRequests(identifier: $0.key) }
    }
}
