//
//  SerachViewController.swift
//  NetflixSafari
//
//  Created by Sachin on 04/07/2026.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    private var titles:[Movies] = [Movies]()
    private let searchTable:UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController:UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "search movie"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        searchTable.delegate = self
        searchTable.dataSource = self
        fetchseach()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.searchController = searchController
        view.addSubview(searchTable)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }
    private func fetchseach(){
        ApiServices.shared.getSearchMovies{ [weak self] result in
            switch result{
            case .success(let title):
                self?.titles = title
                DispatchQueue.main.async{
                    self?.searchTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        
            
        }
    }}

extension SearchViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown", posterUrl: title.poster_path ?? "")
      //  cell.titleLbl.text = "qwertyuiop"
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

extension SearchViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty,query.trimmingCharacters(in: .whitespaces).count>=3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {return
        }
        ApiServices.shared.getSpecificSearchMovies(with: query){reult in
            
            DispatchQueue.main.async{
                switch reult{
                case .success(let titles):
                    resultController.titles = titles
                    resultController.searchResultCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }

    }
    
}

