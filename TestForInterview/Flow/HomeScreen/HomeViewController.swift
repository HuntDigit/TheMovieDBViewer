//
//  (HomeViewController) ViewController.swift // renamed
//  TestForInterview
//
//  Created by Sam Titovskyi on 18.08.2025.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - ViewModel
    let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        taskOnLoad()
        subscribeToChanges()
    }

    // MARK: - UI Setup
    
    private func setupUI() {

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        MovieCollectionCell.registerCell(on: collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
    
    private func taskOnLoad() {
        viewModel.onLoad()
    }
    
    private func subscribeToChanges() {
        viewModel.didUpdateList = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listOfMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cell: MovieCollectionCell.self, for: indexPath)
        let model = viewModel.listOfMovie[indexPath.row]

        cell.setContainerWidth(width: collectionView.frame.width)
        cell.imageView.backgroundColor = .red
        cell.titleLabel.text = model.title
        cell.backgroundColor = .blue
        cell.movieCellBackgroundView.backgroundColor = .yellow
        
        return cell
    }
    
    
}


extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailView()
        let controller = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(controller, animated: true)
    }
}
