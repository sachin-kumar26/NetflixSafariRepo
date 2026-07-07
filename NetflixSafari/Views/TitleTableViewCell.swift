//
//  TitleTableViewCell.swift
//  NetflixSafari
//
//  Created by Sachin on 07/07/2026.
//

import UIKit
import SDWebImage

class TitleTableViewCell: UITableViewCell {

   static let identifier = "TitleTableViewCell"
    
    let playTitleBtn:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.titleLabel?.text = "Play"
        return button
    }()
    
    let titleLbl:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let titlePosterUIImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(playTitleBtn)
        applyConstraints()
    }
    
    private func applyConstraints(){
        let titlePosterUIImageViewConstraints = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100),
            //titlePosterUIImageView.heightAnchor.constraint(equalToConstant: 100)

        ]
        
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor,constant: 20),
            titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]
        let playTitleBtnConstraints = [
            playTitleBtn.leadingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            playTitleBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    
        ]
        
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(playTitleBtnConstraints)

    }
    
    public func configure(with model:TitleViewModel){
       
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else { return }
        titlePosterUIImageView.sd_setImage(with: url,completed: nil)
        titleLbl.text = model.titleName ?? "Unkbown"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
