//
//  RealmStoreTests.swift
//  CMovieSearchAssignmentTests
//
//  Created by Mac iOS on 5/14/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import XCTest
import RealmSwift
@testable import CMovieSearchAssignment

class RealmStoreTests: XCTestCase {
    
    var realmSearchStore: SearchItemDataStore! // System Under Test
    
    override func setUp() {
        super.setUp()
        
        var mockConfiguration = Realm.Configuration()
        mockConfiguration.inMemoryIdentifier = "RealmTestIdentifier"
        realmSearchStore = RealmSearchStore(mockConfiguration)
    }
    
    func testIfItemIsAddedSuccessfully() {
        let itemsBefore = realmSearchStore.allItems.count
        let searchItem = SearchItem()
        realmSearchStore.saveItem(searchItem)
        let itemsAfter = realmSearchStore.allItems.count
        
        XCTAssert(itemsBefore < itemsAfter, "Items before should be less.")
    }
    
    func testIfMaximumOfTenItemsAreReturnedByStore() {
        for _ in 1...15 {
            let searchItem = SearchItem()
            realmSearchStore.saveItem(searchItem)
        }
        
        let recentItems = realmSearchStore.tenRecentItems
        XCTAssert(recentItems.count <= 10, "Should only return maximum 10 items.")
    }
    
    func testIfItemsAreSavedBaseOnPrimaryKey() {
        let item1 = SearchItem(search: "Batman")
        let item2 = SearchItem(search: "Batman")
        
        realmSearchStore.saveItem(item1)
        realmSearchStore.saveItem(item2)
        
        let allItems = realmSearchStore.allItems
        
        XCTAssert(allItems.count == 1, "Both should be treated as same item")
    }
    
    func testIfStoreClearSuccessfully() {
        realmSearchStore.clearStore()
        
        XCTAssert(realmSearchStore.allItems.count == 0, "All item count should be zero after clear function")
    }
    
    override func tearDown() {
        super.tearDown()
        
        realmSearchStore.clearStore()
    }
}
