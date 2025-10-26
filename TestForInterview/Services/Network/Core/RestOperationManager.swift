//
//  RestOperationManager.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

protocol RestOperationsDelegate: AnyObject {
    func execute<Model, RestError>(model: Model.Type,
                                   errorType: RestError.Type,
                                   request: Request,
                                   identifier: String,
                                   completion: @escaping RequestCompletion<Model, RestError>)
    func cancelAllRequests(identifier: String)
}

class RestOperationManager<RestError: BaseRestErrorProtocol> {
    var delegate: RestOperationsDelegate?

    private let contextIdentifier: String
    private var executionHandler: RequestExecutionHandler?
    private var errorHandler: RequestErrorHandler<RestError>?

    required init(contextIdentifier: String) {
        self.contextIdentifier = contextIdentifier
    }

    func assignExecutionHandler(_ executionHandler: @escaping RequestExecutionHandler) {
        self.executionHandler = executionHandler
    }

    func assignErrorHandler(_ errorHandler: @escaping RequestErrorHandler<RestError>) {
        self.errorHandler = errorHandler
    }

    func prepare<Model>(request: Request) -> RestOperation<Model, RestError> {
        typealias RestOperationBundle = RestOperation<Model, RestError>
        
        return RestOperationBundle { [weak self] operation in
            guard let self = self else { return }
            
            if operation.stateCallback == nil {
                self.executionHandler?(.started)
            }
            operation.state = .started
            self.delegate?.execute(model: Model.self,
                                   errorType: RestError.self,
                                   request: request,
                                   identifier: self.contextIdentifier) { result in
                switch result {
                case .success(let model) :
                    operation.model = model
                case .failure(let error):
                    if operation.errorCallback == nil {
                        self.errorHandler?(error)
                    }
                    operation.error = error
                }
                if operation.stateCallback == nil {
                    self.executionHandler?(.ended)
                }
                operation.state = .ended
            }
        }
    }

    deinit {
        delegate?.cancelAllRequests(identifier: contextIdentifier)
    }
}
