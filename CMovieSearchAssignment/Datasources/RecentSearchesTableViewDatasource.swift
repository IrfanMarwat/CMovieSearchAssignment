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
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentSearchCell")
        cell?.accessoryType = .disclosureIndicator
        cell?.backgroundColor = UIColor.groupTableViewBackground
        let item = datasource[indexPath.row]
        cell?.textLabel?.textColor = .black
        cell?.textLabel?.text = item.searchText
        
        return cell!
    }
    
}

// MARK: - <#UITableViewDelegate#>
extension RecentSearchesTableViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

