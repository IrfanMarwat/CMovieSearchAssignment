//
//  ViewController.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    @IBOutlet weak var searchBarMovies: AppSearchBar!
    @IBOutlet weak var tableViewMovies: UITableView!
    var nextResponseCompleted: Bool = false
    
    var movieTableViewDatasource: MovieTableViewDatasource!
    var recentSearchTableViewDatasource: RecentSearchesTableViewDatasource!
    
    var moviesResponse: MovieSearchResponse?
    
    var recentSearches: [SearchItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewMovies.tableFooterView = UIView(frame: .zero)
        searchBarMovies.becomeFirstResponder()
        
        let movieCellNib = MovieTableViewCell.nib
        tableViewMovies.register(movieCellNib, forCellReuseIdentifier: "movieCell")
        tableViewMovies.register(UITableViewCell.self, forCellReuseIdentifier: "recentSearchCell")
        
        movieTableViewDatasource = MovieTableViewDatasource(delegate: self)
        recentSearchTableViewDatasource = RecentSearchesTableViewDatasource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadItems(_ searchText: String, pageToLoad: Int = 1) {
        MovieSearchResponse.searchWith(searchText, pageNumber: pageToLoad) { (error, response) in
            DispatchQueue.main.async {
                guard error == nil else {
                    //                    self.showAlertWithTitle(title: nil, message: error!.localizedDescription, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
                    return
                }
                
                self.moviesResponse = response
                if pageToLoad == 1 {
                    self.movieTableViewDatasource.update(response?.results ?? [])
                } else {
                    self.movieTableViewDatasource.addNextPageMovies(response?.results ?? [])
                }
                self.tableViewMovies.dataSource = self.movieTableViewDatasource
                self.tableViewMovies.delegate = self.movieTableViewDatasource
                self.tableViewMovies.reloadData()
                self.nextResponseCompleted = true
            }
        }
    }
}

extension MovieSearchViewController: MovieVcDelegate {
    var shouldDownloadMore: Bool {
        let bottomReached = tableViewMovies.contentOffset.y >= (tableViewMovies.contentSize.height - tableViewMovies.frame.size.height)
        
        return bottomReached && nextResponseCompleted
    }
    
    
    func loadMoreItems() {
        nextResponseCompleted = false
        if let nextPage = moviesResponse?.nextPage {
            loadItems(searchBarMovies.text!, pageToLoad: nextPage)
        }
    }
}

// MARK: - <#UISearchBarDelegate#>
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarMovies.cancelShown()
        tableViewMovies.dataSource = recentSearchTableViewDatasource
        tableViewMovies.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadItems(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarMovies.cancelHidden()
        searchBarMovies.resignFirstResponder()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarMovies.cancelHidden()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchBarMovies.resignFirstResponder()
    }
}

