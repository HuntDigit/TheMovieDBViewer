//
//  HomeViewModel.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

class HomeViewModel {
    
    var listOfMovie: [MoviesModel] {
        didSet {
            didUpdateList?()
        }
    }
    
    var didUpdateList: (() -> Void)?
    var isLoading: Bool = false

    lazy var networkService = NetworkService.shared.instantiate(MainOperationManager.self, in: self)
    
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    
    init(listOfMovie: [MoviesModel] = []) {
        self.listOfMovie = listOfMovie
    }
    
    func onLoad() {
        isLoading = true
        networkService.getOrdersList(page: currentPage)
            .onComplete { model in
                self.listOfMovie = model.results
                self.totalPages = model.totalPages
                self.isLoading = false
            }
            .onError { error in
                self.isLoading = false
            }
            .run()
    }
    
    func loadMode() {
        
    }
    
    
}
