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
    var tenRecentItems: [SearchItem] {get}
    func deleteItem(_ searchItem: SearchItem)
    var allItems: [SearchItem] {get}
    func clearStore()
}

struct RealmSearchStore: SearchItemDataStore {
    
    var configuration = Realm.Configuration()
    
    init(_ configuration: Realm.Configuration? = nil) {
        if configuration != nil {
            self.configuration = configuration!
        }
    }
    
    func saveItem(_ searchItem: SearchItem) {
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            realm.add(searchItem, update: true)
        }
    }
    
    var allItems: [SearchItem] {
        let realm = try! Realm(configuration: configuration)
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
        let realm = try! Realm(configuration: configuration)
        try! realm.write {
            let allObjects = realm.objects(SearchItem.self)
            realm.delete(allObjects)
        }
    }
}
