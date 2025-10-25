//
//  Operation.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

final class RestOperation<Model: Decodable, Response: BaseRestResponse<Model>, RestError: BaseRestErrorProtocol> {

    private(set) var stateCallback: StateCallback?
    private(set) var uploadProgressCallback: ProgressCallback?
    private(set) var completeCallback: CompleteCallback<Model, Response>?
    private(set) var errorCallback: ErrorCallback<RestError>?

    private var execute: (RestOperation) -> Void

    init(execute: @escaping (RestOperation) -> Void) {
        self.execute = execute
    }

    var state: RequestState? {
        didSet {
            if let state = state {
                stateCallback?(state)
            }
        }
    }

    var response: Response? {
        didSet {
            if let response = response {
                completeCallback?(response)
            }
        }
    }

    var error: APIError<RestError>? {
        didSet {
            if let error = error {
                errorCallback?(error)
            }
        }
    }

    func onStateChanged(_ stateCallback: @escaping StateCallback) -> Self {
        self.stateCallback = stateCallback
        if let state = state {
            stateCallback(state)
        }
        return self
    }

    func onComplete(_ completeCallback: @escaping CompleteCallback<Model, Response>) -> Self {
        self.completeCallback = completeCallback
        if let response = self.response {
            completeCallback(response)
        }
        return self
    }

    func onError(_ errorCallback: @escaping ErrorCallback<RestError>) -> Self {
        self.errorCallback = errorCallback
        if let error = self.error {
            errorCallback(error)
        }
        return self
    }

    func run() {
        self.execute(self)
    }
}
