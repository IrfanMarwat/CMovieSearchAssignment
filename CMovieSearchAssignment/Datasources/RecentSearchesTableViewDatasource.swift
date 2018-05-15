//
//  RecentSearchesTableViewDatasource.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

/*
    UITableview datasource that is assigned to TableView in MovieSearchViewController. When user focus in searchbar this datasource is assigned and tableview is reloaded. This show recent 10 searches. Pressing on item will replace tableview datasource with MovieDatasouce for movie listing.
 */

protocol SearchTableDelegate: class {
    func recentItemSelected(_ text: String)
}

class RecentSearchesTableViewDatasource: NSObject {
    var store: SearchItemDataStore!
    var datasource: [SearchItem] = []
    weak var delegate: SearchTableDelegate? = nil
    
    init(_ realmStore: SearchItemDataStore, delegate: SearchTableDelegate) {
        super.init()
        
        store = realmStore
        self.delegate = delegate
        datasource = store.tenRecentItems
    }
    
    func updatedStore(_ realmStore: SearchItemDataStore) {
        store = realmStore
        datasource = store.tenRecentItems
    }
}

// MARK: - <#UITableViewDataSource#>
extension RecentSearchesTableViewDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentSearchCell")!
        
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.white
        cell.textLabel?.textColor = .black
        
        let item = datasource[indexPath.row]
        cell.textLabel?.text = item.searchText
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}

// MARK: - <#UITableViewDelegate#>
extension RecentSearchesTableViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datasource[indexPath.row]
        delegate?.recentItemSelected(item.searchText)
    }
}

