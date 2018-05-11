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
    
    var movieTableViewDatasource: MovieTableViewDatasource!
    var recentSearchTableViewDatasource: RecentSearchesTableViewDatasource!
    
    var movies: [Movie] = []
    var recentSearches: [SearchItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieTableViewDatasource = MovieTableViewDatasource()
        recentSearchTableViewDatasource = RecentSearchesTableViewDatasource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: - <#UISearchBarDelegate#>
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarMovies.cancelShown()
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

