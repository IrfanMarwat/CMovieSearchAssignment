//
//  ThrottleTests.swift
//  CMovieSearchAssignmentTests
//
//  Created by Mac iOS on 5/14/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import XCTest

class ThrottleTests: XCTestCase {
    
    var throttler: Throttler! // System under test
    var taskCalledCount = 0

    override func setUp() {
        super.setUp()

        throttler = Throttler(seconds: 1.0)
    }

    func testIfTaskExecuteOnlyOnceInGivenTime() {
        let completeExpectaion = expectation(description: "Completed")
        throttler.throttle {
            mockTask()
        }

        func mockTask() {
            taskCalledCount = taskCalledCount + 1
            completeExpectaion.fulfill()
        }
        
        waitForExpectations(timeout: 1.1, handler: nil)
        XCTAssert(taskCalledCount == 1, "mockTask should be called once in given delay 1.0")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
}
