//
//  ViewController.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    @IBOutlet weak var searchBarMovies: UISearchBar!
    @IBOutlet weak var tableViewMovies: UITableView!
    
    var movieTableViewDatasource: MovieTableViewDatasource!
    var recentSearchTableViewDatasource: RecentSearchesTableViewDatasource!
    
    var movies: [Movie] = []
    var recentSearches: [SearchItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

