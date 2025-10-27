//
//  HomeViewModel.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

class HomeViewModel {
    
    lazy var networkService = NetworkService.shared.instantiate(MovieOperationManager.self, in: self)

    var listOfMovie: [MoviesModel] = []
    var didUpdateList: (([MoviesModel]) -> Void)?
    
    private(set) var currentPage: Int = 0
    private(set) var totalPages: Int = 0
    private(set) var isLoading: Bool = false

    private let paginationStep: Int = 2
        
    init(listOfMovie: [MoviesModel] = []) {
        self.listOfMovie = listOfMovie
    }
    
    func loadMode() {
        // Prepare:
        // Extra protection ( not happened but ... )
        if self.isLoading {
            debugPrint("!!! Already loading !!!")
            return
        }
        
        // Step 1:
        // Set up network requests for concurrent execution based on the pagination step and the total number of available pages.
        self.isLoading = true
        
        var operations = [NetworkOperation<TopRatedModelResponse>]()
        for index in 1...paginationStep {
            let page = currentPage + index
            if page == 1 { totalPages = 1 }
            guard page <= totalPages else { break }
            
            debugPrint("Load Page: \(page)")
            
            operations.append(
                networkService.getOrdersList(page: page)
            )
        }
        
        // Step 2:
        // Use our helper to perform several operations concurrently.
        // After that, handle the results to process the data and append it to the main movie list.
        // The result of concurrent operations is unsorted because each task finishes at a different time.
        // Apply minimal sorting and unwrap the list.
        
        OperationGroupProvider.performConcurentOperation(operations: operations) { result in
            self.isLoading = false
            
            switch result {
            case .success(let list):
                let sorted = list
                    .sorted { $0.page < $1.page }
                let movies = sorted.flatMap { $0.results }
                self.didUpdateList?(movies)
                self.currentPage = sorted.last!.page
                self.totalPages = sorted.last!.totalPages
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

