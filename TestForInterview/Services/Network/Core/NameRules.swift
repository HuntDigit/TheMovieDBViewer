//
//  StructAliaces.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

//RestOperationsDelegate
typealias RequestCompletion<Model, RestError> = (Result<Model, APIError<RestError>>) -> Void
    where Model: Decodable, RestError: BaseRestErrorProtocol

//RestOperationsManager
typealias RequestExecutionHandler = (RequestState) -> Void
typealias RequestErrorHandler<RestError> = (APIError<RestError>) -> Void where RestError: BaseRestErrorProtocol

//Operation
typealias StateCallback = (RequestState) -> Void
typealias ProgressCallback = (Double) -> Void
typealias CompleteCallback<Model: Decodable> = (Model) -> Void
typealias ErrorCallback<RestError> = (APIError<RestError>) -> Void where RestError: BaseRestErrorProtocol
