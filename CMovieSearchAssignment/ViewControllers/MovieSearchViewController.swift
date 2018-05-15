//
//  ViewController.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

/*
    Main class for showing movie list. This class contain a store object for recent saved items, recent search datasource and movie datasource. TableView is assigned one of the two datasources depends on user activity.
*/
import UIKit
import NotificationBannerSwift

class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBarMovies: AppSearchBar!
    @IBOutlet weak var tableViewMovies: UITableView!
    
    var nextResponseCompleted: Bool = false
    var activityIndicator: UIActivityIndicatorView?
    
    let throttler = Throttler(seconds: Constants.ThrottlerTime)
    var realmSearchStore: SearchItemDataStore!
    var moviesResponse: MovieSearchResponse?
    
    var movieTableViewDatasource: MovieTableViewDatasource!
    var recentSearchTableViewDatasource: RecentSearchesTableViewDatasource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmSearchStore = RealmSearchStore()
        registerForPreviewing(with: self, sourceView: tableViewMovies) // Previewing delegates are implemented in Separate extension (MovieSearchViewController+PeekAndPop)
        
        tableViewMovies.tableFooterView = UIView(frame: .zero)
        searchBarMovies.becomeFirstResponder()
        
        let movieCellNib = MovieTableViewCell.nib
        tableViewMovies.register(movieCellNib, forCellReuseIdentifier: "movieCell")
        tableViewMovies.register(UITableViewCell.self, forCellReuseIdentifier: "recentSearchCell")
        
        movieTableViewDatasource = MovieTableViewDatasource(delegate: self)
        recentSearchTableViewDatasource = RecentSearchesTableViewDatasource(realmSearchStore, delegate: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifiers.movieDetailSegue {
            let destinationVc = segue.destination as! MovieDetailViewController
            destinationVc.movie = sender as! Movie
        }
    }
    
    func loadItems(_ searchText: String, pageToLoad: Int = 1, completion: (()-> Void)? = nil ) {
        MovieSearchResponse.searchWith(searchText, pageNumber: pageToLoad) { (error, response) in
            DispatchQueue.main.async {
                self.activityIndicator?.hideActivityIndicator()
                self.activityIndicator = nil
                
                guard error == nil else {
                    let banner = StatusBarNotificationBanner(title: error!.errorDescription, style: .warning)
                    banner.show()
                    return
                }
                self.moviesResponse = response
                self.movieTableViewDatasource.update(response?.movies ?? [], pageNumber: pageToLoad)
                self.showMovieDatasource()
                self.nextResponseCompleted = true
                completion?()
            }
        }
    }
    
    func showMovieDatasource() {
        tableViewMovies.dataSource = movieTableViewDatasource
        tableViewMovies.delegate = movieTableViewDatasource
        if #available(iOS 10.0, *) {
            tableViewMovies.prefetchDataSource = movieTableViewDatasource
        }
        tableViewMovies.reloadData()
    }
    
    func showRecentSearchDatasource() {
        if #available(iOS 10.0, *) {
            tableViewMovies.prefetchDataSource = nil
        }
        recentSearchTableViewDatasource.updatedStore(realmSearchStore)
        tableViewMovies.dataSource = recentSearchTableViewDatasource
        tableViewMovies.delegate = recentSearchTableViewDatasource
        tableViewMovies.reloadData()
    }
}

// MARK: - <#MovieVcDelegate#>
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
    
    func showMovieDetail(_ movie: Movie) {
        // save to recent search
        let searchItem = SearchItem(search: movie.title)
        realmSearchStore.saveItem(searchItem)
        
        performSegue(withIdentifier: Constants.SegueIdentifiers.movieDetailSegue, sender: movie)
    }
}

// MARK: - <#SearchTableDelegate#>
extension MovieSearchViewController: SearchTableDelegate {
    func recentItemSelected(_ text: String) {
        searchBarMovies.text = text
        loadItems(text)
    }
}

// MARK: - <#UISearchBarDelegate#>
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarMovies.cancelShown()
        
        if searchBar.text!.count == 0 {
            showRecentSearchDatasource()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            showRecentSearchDatasource()
            return
        }
        if activityIndicator == nil {
            activityIndicator = view.showActivityIndicatory()
        }
        throttler.throttle {
            self.loadItems(searchText)
        }
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
        if searchBar.text!.count > 0 {
            loadItems(searchBarMovies.text!) {
                if let count = self.moviesResponse?.movies?.count, count > 0 {
                    let searchItem = SearchItem(search: searchBar.text!)
                    self.realmSearchStore.saveItem(searchItem)
                }
            }
        }
    }
}

