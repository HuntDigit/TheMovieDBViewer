//
//  (HomeViewController) ViewController.swift // renamed
//  TestForInterview
//
//  Created by Sam Titovskyi on 18.08.2025.
//

import UIKit
import SwiftUI

struct LayoutRules {
    static let horizontalSpacing: CGFloat = 16
    static let itemSpacing: CGFloat = 16
    static let lineSpacing: CGFloat = 16
    static let footerHeight: CGFloat = 70
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - ViewModel
    let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        subscribeToChanges()
    }

    // MARK: - UI Setup
    
    private func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        setupNavigationTitle()
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: .init(named: "search"),
                            style: .plain,
                            target: self,
                            action: #selector(searchTapped)),
            UIBarButtonItem(image: .init(named: "appearance"),
                            style: .plain,
                            target: self,
                            action: #selector(appearanceTapped))
        ]
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Movie"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: titleLabel.frame.height))
        containerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        navigationItem.titleView = containerView
    }
    
    @objc private func searchTapped() {
        
    }
    
    @objc private func appearanceTapped() {
        AppearanceManager.shared.toggleTheme()
    }
    
    private func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = LayoutRules.lineSpacing
            layout.minimumInteritemSpacing = LayoutRules.itemSpacing
            layout.sectionInset.left = LayoutRules.horizontalSpacing
            layout.sectionInset.right = LayoutRules.horizontalSpacing
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
                let offset = self.viewModel.listOfMovie.count == 0 ? 0 : self.viewModel.listOfMovie.count
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

        cell.setContainerWidth(width: collectionView.frame.width - LayoutRules.horizontalSpacing * 3)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: LayoutRules.footerHeight)
    }
}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.listOfMovie[indexPath.row]
        let detailViewModel = DetailViewModel(movieId: model.id)
        let detailView = DetailView(viewModel: detailViewModel)
        let controller = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
