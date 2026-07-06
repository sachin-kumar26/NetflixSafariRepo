//
//  TitlesCollectionViewCell.swift
//  NetflixSafari
//
//  Created by Sachin on 06/07/2026.
//

import UIKit
import SDWebImage

class TitlesCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "TitlesCollectionViewCell"
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func confiure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else { return }
        posterImageView.sd_setImage(with: url)
   
    }
}

