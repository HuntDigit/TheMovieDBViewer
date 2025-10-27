//
//  UIVIew+Extension.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 26.10.2025.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func dequeueReusableCell<CollectionViewCell: UICollectionViewCell>(cell: CollectionViewCell.Type, for indexPath: IndexPath) -> CollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
        guard let cell = cell as? CollectionViewCell else { fatalError("Missmatch cell types") }
        return cell
    }
}

extension UICollectionReusableView {
    static func registerReusableView(on collection: UICollectionView) {
        let nib = UINib(nibName: String(describing: Self.self), bundle: .main)
        collection.register(nib,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                            withReuseIdentifier: Self.identifier)
    }
}

extension UICollectionViewCell {
    static func registerCell(on collection: UICollectionView) {
        let nib = UINib(nibName: String(describing: Self.self), bundle: .main)
        collection.register(nib, forCellWithReuseIdentifier: String(describing: Self.identifier))
    }
}
