//
//  DataStore.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import RealmSwift

protocol SearchItemDataStore {
    func saveItem(_ searchItem: SearchItem)
    func deleteItem(_ searchItem: SearchItem)
    func clearStore()
    var tenRecentItems: [SearchItem] {get}
}

struct RealmSearchStore: SearchItemDataStore {
    
    func saveItem(_ searchItem: SearchItem) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(searchItem, update: true)
        }
    }
    
    private var allItems: [SearchItem] {
        let realm = try! Realm()
        let results = realm.objects(SearchItem.self)
        let listOfCartItems = results.reduce(List<SearchItem>()) { (list, element) -> List<SearchItem> in
            list.append(element)
            return list
        }
        
        let listOfSearchedItems = Array(listOfCartItems)
        
        return listOfSearchedItems
    }
    
    var tenRecentItems: [SearchItem] {
        let sortedItems = allItems.sorted { (item1, item2) -> Bool in
            return item1.searchedDate > item2.searchedDate
        }
        
        return Array(sortedItems.prefix(Constants.maxRecentItemCount))
    }
    
    func deleteItem(_ searchItem: SearchItem) {
        
    }
    
    func clearStore() {
        let realm = try! Realm()
        try! realm.write {
            let allObjects = realm.objects(SearchItem.self)
            realm.delete(allObjects)
        }
    }
}
