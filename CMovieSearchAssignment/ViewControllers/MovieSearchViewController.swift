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
        
        tableViewMovies.tableFooterView = UIView(frame: .zero)
        
        let movieCellNib = MovieTableViewCell.nib
        tableViewMovies.register(movieCellNib, forCellReuseIdentifier: "movieCell")
        tableViewMovies.register(UITableViewCell.self, forCellReuseIdentifier: "recentSearchCell")
        
        let recentSearches = [SearchItem(searchText: "Black Panther", searchedDate: Date()), SearchItem(searchText: "Gotham", searchedDate: Date()), SearchItem(searchText: "Black Panther", searchedDate: Date())]
        
        let allMovies = [Movie(name: "Black Panther", releaseDate: "20-Oct-2017", review: "Not good jsut bad", imagePath: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"), Movie(name: "Black Panther", releaseDate: "19-Oct-2017", review: "Not good", imagePath: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"), Movie(name: "Black Panther", releaseDate: "21-Oct-2017", review: "Not goodlksdj flds jfdls kjfdls kjf dslkjf ldsk jflkds jflksd jfklds jflkds jflkds jflkds jflds kjfl dskjf lkdsj flkds jfldsjf", imagePath: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")]
        
        movieTableViewDatasource = MovieTableViewDatasource(allMovies)
        recentSearchTableViewDatasource = RecentSearchesTableViewDatasource(recentSearches)
        
        tableViewMovies.dataSource = movieTableViewDatasource
        tableViewMovies.delegate = movieTableViewDatasource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - <#UISearchBarDelegate#>
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarMovies.cancelShown()
        tableViewMovies.dataSource = recentSearchTableViewDatasource
        tableViewMovies.reloadData()
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

