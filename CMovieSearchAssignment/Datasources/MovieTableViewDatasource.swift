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
//        if datasource.count == 0 {
//            return 1 // No Result found cell.
//        }
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if datasource.count == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "recentSearchCell")!
//            cell.accessoryType = .none
//            cell.textLabel?.text = "No Result Found"
//            return cell
//        }
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
        tableView.deselectRow(at: indexPath, animated: false)
        delegateToMovieVc?.showMovieDetail(datasource[indexPath.row])
    }
}

extension MovieTableViewDatasource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach{self.downloadImage($0.row)}
    }
    
    func downloadImage(_ index: Int) {
        var movie = datasource[index]
        if let imageName = movie.posterPath?.replacingOccurrences(of: "'\'", with: "") {
            let imageFullPath = Constants.BASE_URL_IMAGE + Constants.thumbnailSize + imageName
            
            NetworkImageDownloader.shared.downlaodImageAtURLString(imageFullPath, withPlaceholder: "MovieDefault", imageIdentifier: "") { (image, success) in
                movie.movieImage = image
                self.datasource[index] = movie
            }
        }
    }
}
