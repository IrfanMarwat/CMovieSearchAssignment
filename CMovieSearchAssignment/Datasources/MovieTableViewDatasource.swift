//
//  MovieTableViewDatasource.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

class MovieTableViewDatasource: NSObject {
    var datasource: [Movie] = []
    
    init(_ movies: [Movie]? = nil) {
        super.init()
        
        if let movies = movies {
            datasource = movies
        }
    }
    
    func update(_ newMovies: [Movie]) {
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

}

// MARK: - <#UITableViewDelegate#>
extension MovieTableViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
