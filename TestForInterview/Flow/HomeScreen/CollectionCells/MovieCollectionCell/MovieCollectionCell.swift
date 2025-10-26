//
//  MovieCollectionCell.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 26.10.2025.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCellBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var boundingWidth: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
 
    private func setupView() {
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attribute = super.preferredLayoutAttributesFitting(layoutAttributes)
        let width = boundingWidth / 2.0
        attribute.size = .init(width: width, height: width * 1.5)
        return attribute
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setContainerWidth(width: CGFloat) {
        self.boundingWidth = width
    }
}

