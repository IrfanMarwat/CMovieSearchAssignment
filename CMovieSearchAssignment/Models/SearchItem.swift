//
//  SearchItem.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import RealmSwift

class SearchItem: Object {
    @objc dynamic var searchText: String = ""
    @objc dynamic var searchedDate: Date = Date()
    
    convenience init(search: String) {
        self.init()
        searchText = search
        searchedDate = Date()
    }
    
    override class func primaryKey() -> String {
        return "searchText"
    }
}
