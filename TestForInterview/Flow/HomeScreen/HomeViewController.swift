//
//  (HomeViewController) ViewController.swift // renamed
//  TestForInterview
//
//  Created by Sam Titovskyi on 18.08.2025.
//

import UIKit
import SwiftUI

fileprivate let kDefaultCellId = "CellId"

class HomeViewController: UIViewController {

    // MARK: - ViewModel
    let viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        taskOnLoad()
    }

    // MARK: - UI Setup
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kDefaultCellId)
        
        collectionView.reloadData()
    }
    
    private func taskOnLoad() {
        viewModel.onLoad()
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDefaultCellId, for: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? .lightGray : .red.withAlphaComponent(0.3)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailView()
        let controller = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(controller, animated: true)
    }
}
