//
//  RecentSearchesTableViewDatasource.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

class RecentSearchesTableViewDatasource: NSObject {
    var datasource: [SearchItem] = []
    
    init(_ recentSearches: [SearchItem]? = nil) {
        super.init()
        
        if let recentSearches = recentSearches {
            datasource = recentSearches
        }
    }
}

// MARK: - <#UITableViewDataSource#>
extension RecentSearchesTableViewDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
    }
    
}

// MARK: - <#UITableViewDelegate#>
extension RecentSearchesTableViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

