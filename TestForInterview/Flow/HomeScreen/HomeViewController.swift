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
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        self.title = "Movie"
        
        setupUI()
        subscribeToChanges()
    }

    // MARK: - UI Setup
    
    private func setupUI() {

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.sectionInset.left = 16
            layout.sectionInset.right = 16
        }
        
        //Register ** Cell **
        MovieCollectionCell.registerCell(on: collectionView)
        
        //Register ** View **
        MovieFooterActivityView.registerReusableView(on: collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
    
    func subscribeToChanges() {
        
        viewModel.didUpdateList = { [weak self] newItems in
            DispatchQueue.main.async {
                guard let self = self else { return }

                // Insert new items at the top of the data source
                let offset = self.viewModel.listOfMovie.count == 0 ? 0 : self.viewModel.listOfMovie.count - 1
                self.viewModel.listOfMovie.insert(contentsOf: newItems, at: offset)
                
                
                let start = offset
                let end = offset + newItems.count
                
                let newIndexPaths = (start..<end).map {
                    IndexPath(item: $0, section: 0)
                }
                
                self.collectionView.performBatchUpdates {
                    self.collectionView.insertItems(at: newIndexPaths)
                }
            }
        }
    }
}

extension HomeViewController: MovieFooterActivityViewDelegate {
    func performLoadMore() {
        viewModel.loadMode()
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

        cell.setContainerWidth(width: collectionView.frame.width - 16*3)
        cell.configure(with: model)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
              let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MovieFooterActivityView.identifier,
                for: indexPath
              ) as? MovieFooterActivityView else {
            return UICollectionReusableView()
        }
        
        footerView.delegate = self
        footerView.viewWillShow()
        
        return footerView
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let setOfMovie = Set<MoviesModel>(viewModel.listOfMovie)
//        if setOfMovie.count != viewModel.listOfMovie.count {
//            print("Duplicate Found")
//        } else {
//            print("All are unique")
//        }
        
        let model = viewModel.listOfMovie[indexPath.row]
        let detailViewModel = DetailViewModel(movieId: model.id)
        let detailView = DetailView(viewModel: detailViewModel)
        let controller = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(controller, animated: true)
    }
}
