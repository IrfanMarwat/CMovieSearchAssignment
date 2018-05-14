//
//  RecentSearchesTableViewDatasource.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

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
        cell.backgroundColor = UIColor.groupTableViewBackground
        cell.textLabel?.textColor = .black
        
        let item = datasource[indexPath.row]
        cell.textLabel?.text = item.searchText
        
        return cell
    }
    
}

// MARK: - <#UITableViewDelegate#>
extension RecentSearchesTableViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            store.clearStore()
//            datasource = []
//            tableView.reloadData()
//            return
//        }
        let item = datasource[indexPath.row]
        delegate?.recentItemSelected(item.searchText)
    }
}

