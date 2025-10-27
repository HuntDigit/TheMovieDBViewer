//
//  MovieCollectionCell.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 26.10.2025.
//

import UIKit

import SDWebImage

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCellBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    private var boundingWidth: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
 
    private func setupView() {
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        ratingLabel.font = .systemFont(ofSize: 10, weight: .medium)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attribute = super.preferredLayoutAttributesFitting(layoutAttributes)
        let width = boundingWidth / 2.0
        attribute.size = .init(width: width, height: width * 1.65)
        return attribute
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
    }
    
    func setContainerWidth(width: CGFloat) {
        self.boundingWidth = width
    }
}

extension MovieCollectionCell {
    func configure(with movie: MoviesModel) {
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(String(format: "%.1f", movie.voteAverage))"
        
        imageView.backgroundColor = .gray
        
        if let imageURL = movie.fullPosterURL {
            imageView.sd_setImage(with: imageURL)
        } else {
            imageView.image = nil
        }
    }
}
