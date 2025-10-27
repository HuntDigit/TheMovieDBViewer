//
//  OperationGroupProvider.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import Foundation

struct OperationGroupProvider {
    
    static func performConcurentOperation<Model>(
        operations: [NetworkOperation<Model>],
        operationsCompletion: @escaping (Result<[Model], Error>) -> Void) {
            
        let group  = DispatchGroup()
        let global = DispatchQueue.global()
        
        var operationResult:[Model] = []
        var operationError: Error?
        
        for operation in operations {
            group.enter()
            operation.onComplete { model in
                global.sync {
                    operationResult.append(model)
                }
                group.leave()
            }
            .onError { error in
                global.sync {
                    operationError = error
                    debugPrint("performConcurentOperation run with error: \(error)")
                    debugPrint("other operation in group will be ignored")
                }
                group.leave()
            }
            .run()
        }
        
        group.notify(flags: [.barrier], queue: .main) {
            if let error = operationError {
                operationsCompletion(.failure(error))
            } else {
                operationsCompletion(.success(operationResult))
            }
        }
    }
}
