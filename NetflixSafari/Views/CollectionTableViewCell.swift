//
//  CollectionTableViewCell.swift
//  NetflixSafari
//
//  Created by Sachin on 05/07/2026.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    static let identifier = "CollectionTableViewCell"
    
    private var titles:[Movies] = [Movies]()
    
    
    private let collectonView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitlesCollectionViewCell.self, forCellWithReuseIdentifier: TitlesCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectonView)
        collectonView.delegate = self
        collectonView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectonView.frame = contentView.bounds
    }
    
    public func configure(with title: [Movies]) {
        self.titles = title
        DispatchQueue.main.async {[weak self] in
            self?.collectonView.reloadData()
        }
    }
    
}

extension CollectionTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitlesCollectionViewCell.identifier, for: indexPath) as? TitlesCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = titles[indexPath.row].poster_path else { return cell }
        cell.confiure(with: model)
        return cell
    }
}
