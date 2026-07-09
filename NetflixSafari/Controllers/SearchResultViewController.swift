//
//  SearchResultViewController.swift
//  NetflixSafari
//
//  Created by Sachin on 08/07/2026.
//

import UIKit

class SearchResultViewController: UIViewController{
  
    public var titles:[Movies] = [Movies]()

     public var searchResultCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
      
         layout.itemSize = CGSize(width: 120, height: 180)
         let collectioView = UICollectionView(frame: .zero,collectionViewLayout: layout)
         collectioView.register(TitlesCollectionViewCell.self, forCellWithReuseIdentifier: TitlesCollectionViewCell.identifier)
         return collectioView
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        view.addSubview(searchResultCollectionView)
       // setupCollectionView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds

    }
    

}



extension SearchResultViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitlesCollectionViewCell.identifier, for:indexPath) as? TitlesCollectionViewCell
    else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        cell.confiure(with: title.poster_path ?? "")
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    
    
}
