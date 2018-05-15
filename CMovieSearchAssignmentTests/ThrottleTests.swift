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
    var delay = 0.5

    override func setUp() {
        super.setUp()

        throttler = Throttler(seconds: delay)
    }

    func testIfTaskExecuteOnlyOnceInGivenTime() {
        let completeExpectaion = expectation(description: "Completed")
        for i in 1...10 {
            throttler.throttle {
                mockTask()
            }
        }
        
        func mockTask() {
            taskCalledCount = taskCalledCount + 1
            completeExpectaion.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssert(taskCalledCount == 1, "mockTask should be called once in given delay \(delay)")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
