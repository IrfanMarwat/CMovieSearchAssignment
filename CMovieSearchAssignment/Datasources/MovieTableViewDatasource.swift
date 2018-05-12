//
//  MovieTableViewDatasource.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

protocol MovieVcDelegate: class {
    func loadMoreItems()
    var shouldDownloadMore: Bool {get}
}

class MovieTableViewDatasource: NSObject {
    var datasource: [Movie] = []
    weak var delegateToMovieVc: MovieVcDelegate? = nil
    
    init(_ movies: [Movie]? = nil, delegate: MovieVcDelegate) {
        super.init()
        
        if let movies = movies {
            datasource = movies
        }
        delegateToMovieVc = delegate
    }
    
    func update(_ newMovies: [Movie]) {
        datasource = newMovies
    }
    
    func addNextPageMovies(_ newMovies: [Movie]) {
        datasource.append(contentsOf: newMovies)
    }
}

// MARK: - <#UITableViewDataSource#>
extension MovieTableViewDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let movie = datasource[indexPath.row]
        cell.configureWith(movie)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if delegateToMovieVc?.shouldDownloadMore ?? false {
            delegateToMovieVc?.loadMoreItems()
        }
    }
}

// MARK: - <#UITableViewDelegate#>
extension MovieTableViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
