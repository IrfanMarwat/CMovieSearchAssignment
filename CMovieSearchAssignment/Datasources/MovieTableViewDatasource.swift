//
//  MovieTableViewDatasource.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

/*
    MovieVcDelegate is confirmed by MovieSearchViewController.
    MovieTableViewDatasource class has UITableview datasources and delegates methods, for listing movies. Prefetch is also implemented by this. The update function will replace all items for first page, and append items for other pages.
 */

protocol MovieVcDelegate: class {
    func loadMoreItems()
    var shouldDownloadMore: Bool {get}
    func showMovieDetail(_ movie: Movie)
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
    
    func update(_ newMovies: [Movie], pageNumber: Int = 1) {
        if pageNumber == 1 {
            datasource = newMovies
        } else {
            datasource.append(contentsOf: newMovies)
        }
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
}

// MARK: - <#UITableViewDelegate#>
extension MovieTableViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegateToMovieVc?.showMovieDetail(datasource[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if delegateToMovieVc?.shouldDownloadMore ?? false {
            delegateToMovieVc?.loadMoreItems()
        }
    }
}

// MARK: - <#UITableViewDataSourcePrefetching#>
extension MovieTableViewDatasource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach{self.downloadImage($0.row)}
    }
    
    func downloadImage(_ index: Int) {
        guard index < datasource.count else {
            return
        }
        
        var movie = datasource[index]
        if let imageName = movie.posterPath?.replacingOccurrences(of: "'\'", with: "") {
            let imageFullPath = Constants.BASE_URL_IMAGE + Constants.thumbnailSize + imageName
            
            NetworkImageDownloader.shared.downlaodImageAtURLString(imageFullPath, withPlaceholder: "MovieDefault", imageIdentifier: "") { (image, success) in
                movie.movieImage = image
                if index < self.datasource.count {
                    self.datasource[index] = movie
                }
            }
        }
    }
}
