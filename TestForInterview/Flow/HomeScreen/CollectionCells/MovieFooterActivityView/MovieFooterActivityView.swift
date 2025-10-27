//
//  MovieFooterActivityView.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import UIKit

protocol MovieFooterActivityViewDelegate: AnyObject {
    func performLoadMore()
}

class MovieFooterActivityView: UICollectionReusableView {
    
    weak var delegate: MovieFooterActivityViewDelegate?
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
    
    func viewWillShow() {
        delegate?.performLoadMore()
    }
}
