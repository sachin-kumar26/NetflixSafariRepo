//
//  HomeViewController.swift
//  NetflixSafari
//
//  Created by Sachin on 04/07/2026.
//

import UIKit


enum Section:Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case PopularMovies = 2
    case UpcomingMovies = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTiles:[String] = ["trending Movies","Trending Tv", "Popular Movies", "Upcoming Movies", "Top Rated"]
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.backgroundColor = .systemBackground
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavbar()
        let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        
        
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflix_logo")
        image = resizeImage(image, targetSize: CGSize(width: 30, height: 30))
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .plain, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func fetchData(){
//        ApiServices.shated.getTrendingMovies{
//            results in
//            switch results{
//            case .success(let movies):
//                print(movies)
//            case .failure(let error):
//                print(error)
//            }
        
        ApiServices.shated.getTopRatedMovies{ result in}
        
        
    }

    //// this is to resixe image
    private func resizeImage(_ image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTiles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case Section.TrendingMovies.rawValue:
            ApiServices.shated.getTrendingMovies{result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
                
            }
        case Section.TrendingTv.rawValue:
            ApiServices.shated.getTrendingTvs{result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
                
            }
        case Section.PopularMovies.rawValue:
            ApiServices.shated.getPopularMovies{result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
                
            }
        case Section.UpcomingMovies.rawValue:
            ApiServices.shated.getUpcomingMovies{result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
                
            }
        case Section.TopRated.rawValue:
            ApiServices.shated.getTopRatedMovies{result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
                
            }
        default:
            return UITableViewCell()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTiles[section]
    }
}
