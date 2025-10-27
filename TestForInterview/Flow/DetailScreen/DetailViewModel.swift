//
//  DetailViewModel.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    lazy var networkService = NetworkService.shared.instantiate(MovieOperationManager.self, in: self)

    @Published var detailModelModel: DetailMoviesModel?
    @Published var error: Error?
    
    private var movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func onLoad() {
        networkService.getMovieDetails(id: movieId)
            .onComplete { [weak self] model in
                self?.detailModelModel = model
            }
            .onError { [weak self] error in
                self?.error = error
            }
            .run()
    }
}

