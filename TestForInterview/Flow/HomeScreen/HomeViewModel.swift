//
//  HomeViewModel.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 25.10.2025.
//

import Foundation

class HomeViewModel {
    
    var arrayOfData: [String] = []
    lazy var networkService = NetworkService.shared.instantiate(MainOperationManager.self, in: self)
    
    private var currentPage: Int = 1
    
    func onLoad() {
        networkService.getOrdersList(page: currentPage)
            .onComplete { data in
                
            }
            .onError { error in
            
            }
            .run()
    }
    
    func loadMode() {
        
    }
    
    
}
