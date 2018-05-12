//
//  MovieSearchViewControllerTests.swift
//  CMovieSearchAssignmentTests
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import XCTest
import UIKit

class MovieSearchViewControllerTests: XCTestCase {
    
    var viewController: MovieSearchViewController?
    
    override func setUp() {
        super.setUp()
        
        
//        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieSearchViewController") as? MovieSearchViewController
//        print(viewController)
    }
    
    func testIfViewControllerIsComposedOfSearchBar() {
//        XCTAssertNil(viewController.searchBar, "Search bar should not be nil")
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
